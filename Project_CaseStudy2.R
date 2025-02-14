
#####Packages and Libraries#####


#install.packages('ggplot2') #plotting
#install.packages('GGally') #ggpairs
#install.packages('dlookr') #For Pareto Chart
#install.packages('visdat') #Vis_miss
#install.packages('forcats') #Data ordering
#install.packages("class") #Modeling
#install.packages("caret") #Modeling
#install.packages("e1071") #Modeling
#install.packages("magrittr") #Forward Piping
#install.pacakges("leaps")
#install.packages("dplyr")
#install.packages("ggthemes")



#Call Libraries#
library(dplyr)
library(ggplot2)
library(dlookr)
library(visdat)
library(GGally)
library(forcats)
library(class)
library(caret)
library(e1071)
library(magrittr)
library(leaps)
library(ggthemes)

######Import Data#####
caseStudy<-data.frame(read.csv('/Users/ZacharyHarris/Desktop/MS Data Science/MSDS_6306_Doing-Data-Science-Master/Unit 14 and 15 Case Study 2/CaseStudy2-data.csv'))


#####Cleaning,Summarizing, and Tidying Data#####
#Summarize Data (Head, Tail, Summary, NA Values)
head(caseStudy, 6) #First six lines of data
tail(caseStudy, 6) #Last six lines of data
summary(caseStudy) #Summary of Data
plot_na_pareto(caseStudy, only_na = TRUE) #NA Values
plot_na_intersect(caseStudy) #NA Values 
vis_miss(caseStudy) #NA Values



#####Exploratory Data Analysis - Looking for correlations and items to study#####
#Uncomment line below to get a detailed analysis - 'dplyr' must be installed
#eda_report(caseStudy, output_format = 'html')

#Job Role Histogram
ggplot(caseStudy ,aes(x=fct_infreq(JobRole), fill = JobRole)) + 
  geom_histogram(stat = 'count')+ 
  coord_flip() + theme_clean() + ggtitle('Number of Employees by Job Role')+
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(stat="count", aes(label=..count.., hjust =-0.5, vjust=0)) + 
  xlab('Job Role') + ylab('Number of Employees')

#Job Role Histogram with Attrition
ggplot(caseStudy ,aes(x=fct_infreq(JobRole), fill = Attrition)) + 
  geom_histogram(stat = 'count', position = 'dodge')+ 
  coord_flip() + theme_clean() + ggtitle('Number of Employees by Job Role')+
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(stat="count", aes(label=..count.., hjust =-0.5, vjust=0)) + 
  xlab('Job Role') + ylab('Number of Employees')

#Monthly Income by Education Field
ggplot(caseStudy, aes(x=fct_infreq(EducationField), y = MonthlyIncome, fill = Attrition)) +
  geom_boxplot() +theme_clean() + xlab('Education Field') +ylab('Monthly Income') + 
  ggtitle('Incomes by Education Field') + theme_clean() + 
  theme(plot.title = element_text(hjust = 0.5)) 

#Attrition Histogram
ggplot(caseStudy, aes(x=fct_infreq(Attrition), fill = Attrition)) +
  geom_histogram(stat = "count") + ylim(0,800) +
  ggtitle('Number of Attritions') + theme_clean() + 
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0))+
  xlab('Attrition (Yes/No)')+ ylab('Number of Employees')






#Creating Overall Satisfaction variable
caseStudy$OverallSatisfaction = (caseStudy$JobSatisfaction+
                                   caseStudy$RelationshipSatisfaction+
                                   caseStudy$EnvironmentSatisfaction+
                                   caseStudy$JobInvolvement)




#Job Satisfaction and Attrition
ggplot(caseStudy, aes(x=JobSatisfaction, fill = Attrition)) + theme_clean()+
  geom_bar(stat="count", position = "dodge") + 
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0)) +
  xlab('Job Satisfaction Rating') + ylab('Number of Employees') + 
  ggtitle('Job Satisfaction Ratings')+ theme(plot.title = element_text(hjust = 0.5))

#Relationship Satisfaction and Attrition
ggplot(caseStudy, aes(x=RelationshipSatisfaction, fill = Attrition)) + 
  geom_bar(stat="count", position = "dodge") +
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0)) +theme_clean()+
  xlab('Relationship Satisfaction Rating') + ylab('Number of Employees') + 
  ggtitle('Relationship Satisfaction Ratings')+ theme(plot.title = element_text(hjust = 0.5)) 

#Environment Satisfaction and Attrition
ggplot(caseStudy, aes(x=EnvironmentSatisfaction, fill = Attrition)) + 
  geom_bar(stat="count", position = "dodge") +
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0))+theme_clean()+
  xlab('Environment Satisfaction Rating') + ylab('Number of Employees') + 
  ggtitle('Environment Satisfaction Ratings')+ theme(plot.title = element_text(hjust = 0.5)) 

#Job Involvement and Attrition
ggplot(caseStudy, aes(x=JobInvolvement, fill = Attrition)) + theme_clean()+
  geom_bar(stat="count", position = "dodge") +
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0))+
  xlab('Job Involvement Rating') + ylab('Number of Employees') + 
  ggtitle('Job Involvement Ratings')+ theme(plot.title = element_text(hjust = 0.5)) 

#Overall Satisfaction and Attrition
ggplot(caseStudy, aes(x=OverallSatisfaction, fill = Attrition)) + theme_clean()+
  geom_bar(stat="count", position = "dodge")  +
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0)) + 
  xlab('Overall Satisfaction') + ylab('Number of Employees') + 
  ggtitle('Overall Satisfaction Rating')+ theme(plot.title = element_text(hjust = 0.5))

#Age and Attrition
ggplot(caseStudy, aes(x=Age, fill = Attrition)) + theme_clean()+
  geom_bar(stat="count", position = "dodge") +
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0))+
  xlab('Age') + ylab('Number of Employees') + 
  ggtitle('Attrition by Age')+ theme(plot.title = element_text(hjust = 0.5)) 


#Stock Option Level and Attrition
ggplot(caseStudy, aes (x=StockOptionLevel, fill = Attrition)) + theme_clean()+
  geom_bar(stat = "count", position = "dodge") + theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(stat = "count", aes(label=..count.., hjust = 0.5, vjust = -1.0)) +
  xlab('Stock Option Level') + ylab('Number of Employees') + ggtitle('Stock Option Levels')

#Age and Monthly Income
ggplot(caseStudy, aes(x= Age, y=MonthlyIncome, color = Attrition))+ theme_clean()+
  geom_point() + xlab('Age') + ylab('Monthly Income') + ggtitle('Monthly Income vs. Age') +
  theme(plot.title = element_text(hjust = 0.5))

#Job Role and Monthly Income
ggplot(caseStudy, aes(x= JobRole, y=MonthlyIncome, color = Attrition))+
  geom_boxplot() + theme_clean() + xlab('Job Role') + ylab('Monthly Income') + 
  ggtitle('Monthly Income vs. Age') +
  theme(plot.title = element_text(hjust = 0.5))

#Job Level and Monthly Income
ggplot(caseStudy, aes(x= JobLevel, y=MonthlyIncome, color = Attrition))+
  geom_boxplot() + theme_clean() + xlab('Job Role') + ylab('Monthly Income') + 
  ggtitle('Monthly Income vs. Age') +
  theme(plot.title = element_text(hjust = 0.5))

#Job Level and Attrition
ggplot(caseStudy, aes(x= JobLevel, fill = Attrition))+
  geom_histogram(stat = 'count', position = "dodge") + theme_clean() +
  xlab('Job Level') + ylab('Number of Employees') + 
  ggtitle('Attrition by Job Level') +
  theme(plot.title = element_text(hjust = 0.5)) + 
  geom_text(stat="count", aes(label=..count.., hjust =0.5, vjust=-1.0))
  
# Correlations
ggpairs(select(caseStudy, JobLevel, MonthlyIncome, TotalWorkingYears,
               YearsInCurrentRole, YearsAtCompany,PerformanceRating,
               PercentSalaryHike,YearsWithCurrManager,YearsSinceLastPromotion))


#####KNN Classifier#####
#Attrition vs. Overall Satisfaction



#set.seed will help you generate the same data if you want it consistant
#set.seed(19)




#Split data set into partially test and partially train 
splitPerc = .70     

#Filters data set, unneeded since all is yes and no. 
#If the attrition value for a specific row was left blank, this would eliminate the probelm
attritionYesNo = caseStudy %>% filter(Attrition == "Yes" | Attrition == "No")
summary(attritionYesNo)

#Assining test and train
trainIndices = sample(1:dim(attritionYesNo)[1],round(splitPerc * dim(attritionYesNo)[1]))
train = attritionYesNo[trainIndices,]
test = attritionYesNo[-trainIndices,]

# k = ?
classifications = knn(train[,c(16,30,37)],test[,c(16,30,37)],train$Attrition, prob = TRUE, k = 13)
table(classifications,test$Attrition)
confusionMatrix(table(classifications,test$Attrition))

testNoAttrition<-data.frame(read.csv('/Users/ZacharyHarris/Desktop/MS Data Science/MSDS_6306_Doing-Data-Science-Master/Unit 14 and 15 Case Study 2/CaseStudy2CompSet No Attrition.csv'))

#Creating Overall Satisfaction variable
testNoAttrition$OverallSatisfaction = (testNoAttrition$JobSatisfaction+
                                         testNoAttrition$RelationshipSatisfaction+
                                         testNoAttrition$EnvironmentSatisfaction+
                                         testNoAttrition$JobInvolvement)

prediction = knn(train[1:300,c(14,28,36)],testNoAttrition[,c(14,28,36)],train[1:300,c(3)], prob = TRUE, k = 13)
table(prediction,test$Attrition[1:300])
confusionMatrix(table(prediction,test$Attrition[1:300]))

prediction_final<-data.frame(testNoAttrition$ID,prediction)
colnames(prediction_final)<-c('ID','Attrition')
write.csv(prediction_final,"/Users/ZacharyHarris/Desktop/Case2PredictionsMissingAttrition.csv", row.names = FALSE)

# Loop for many k and one training / test partition

accs = data.frame(accuracy = numeric(30), k = numeric(30))
sens = data.frame(sensitivity = numeric(30), k = numeric(30))
spec = data.frame(specificity = numeric(30), k = numeric(30))

for(i in 1:30)
{
  classifications = knn(train[,c(16,30,37)],test[,c(16,30,37)],train$Attrition, prob = TRUE, k = i)
  table(test$Attrition,classifications)
  CM = confusionMatrix(table(test$Attrition,classifications))
  accs$accuracy[i] = CM$overall[1]
  accs$k[i] = i
  sens$sensitivity[i]=CM$byClass[1]
  sens$k[i] = i
  spec$specificity[i]=CM$byClass[2]
  spec$k[i] = i
}
par(mfrow=c(3,1))
plot(accs$k,accs$accuracy, type = "l", xlab = "k")
axis(1, xaxp=c(0, 30, 30))
plot(sens$k,sens$sensitivity, type ="l", xlab = "k")
axis(1, xaxp=c(0, 30, 30))
plot(spec$k,spec$specificity, type = "l", xlab = "k")
axis(1, xaxp=c(0, 30, 30))

#####Linear Regression#####


#Modify caseStudy dataframe to contain on/off switches for qualitative variables
#Eliminating columns I do not need for the next set of operations
caseStudyModified <- subset(caseStudy,select=-c(ID, Over18, Attrition))

#BusinessTravel - 
caseStudyModified$BusinessTravel[caseStudyModified$BusinessTravel=="Non-Travel"]<-0
caseStudyModified$BusinessTravel[caseStudyModified$BusinessTravel=="Travel_Frequently"]<-1
caseStudyModified$BusinessTravel[caseStudyModified$BusinessTravel=="Travel_Rarely"]<-2

#Department - 
caseStudyModified$Department[caseStudyModified$Department=="Sales"]<-0
caseStudyModified$Department[caseStudyModified$Department=="Human Resources"]<-1
caseStudyModified$Department[caseStudyModified$Department=="Research & Development"]<-2

#EducationField - 
caseStudyModified$EducationField[caseStudyModified$EducationField=="Human Resources"]<-0
caseStudyModified$EducationField[caseStudyModified$EducationField=="Technical Degree"]<-1
caseStudyModified$EducationField[caseStudyModified$EducationField=="Medical"]<-2
caseStudyModified$EducationField[caseStudyModified$EducationField=="Life Sciences"]<-3
caseStudyModified$EducationField[caseStudyModified$EducationField=="Other"]<-4
caseStudyModified$EducationField[caseStudyModified$EducationField=="Marketing"]<-5

#Gender - 
caseStudyModified$Gender[caseStudyModified$Gender=="Female"]<-0
caseStudyModified$Gender[caseStudyModified$Gender=="Male"]<-1

#JobRole - 
caseStudyModified$JobRole[caseStudyModified$JobRole=="Sales Representative"]<-0
caseStudyModified$JobRole[caseStudyModified$JobRole=="Human Resources"]<-1
caseStudyModified$JobRole[caseStudyModified$JobRole=="Lab Technician"]<-2
caseStudyModified$JobRole[caseStudyModified$JobRole=="Laboratory Technician"]<-2
caseStudyModified$JobRole[caseStudyModified$JobRole=="Research Scientist"]<-3
caseStudyModified$JobRole[caseStudyModified$JobRole=="Sales Executive"]<-4
caseStudyModified$JobRole[caseStudyModified$JobRole=="Manufacturing Director"]<-5
caseStudyModified$JobRole[caseStudyModified$JobRole=="Healthcare Representative"]<-6
caseStudyModified$JobRole[caseStudyModified$JobRole=="Research Director"]<-7
caseStudyModified$JobRole[caseStudyModified$JobRole=="Manager"]<-8

#MaritalStatus - 
caseStudyModified$MaritalStatus[caseStudyModified$MaritalStatus=="Divorced"]<-0
caseStudyModified$MaritalStatus[caseStudyModified$MaritalStatus=="Single"]<-1
caseStudyModified$MaritalStatus[caseStudyModified$MaritalStatus=="Married"]<-2

#OverTime - 
caseStudyModified$OverTime[caseStudyModified$OverTime=="No"]<-0
caseStudyModified$OverTime[caseStudyModified$OverTime=="Yes"]<-1



#Determine fit using all variables. Elimination will be based on whether variable has effect on model

fit = lm(MonthlyIncome~BusinessTravel + DailyRate + Department + DistanceFromHome + 
           Education + EducationField + EmployeeCount + EmployeeNumber + 
           EnvironmentSatisfaction + Gender + HourlyRate + JobInvolvement + 
           JobLevel + JobRole + JobSatisfaction + MaritalStatus + MonthlyIncome + 
           MonthlyRate + NumCompaniesWorked + OverTime + PercentSalaryHike + 
           PerformanceRating + RelationshipSatisfaction + StandardHours + 
           StockOptionLevel + TotalWorkingYears + TrainingTimesLastYear + 
           WorkLifeBalance + YearsAtCompany + YearsInCurrentRole + YearsSinceLastPromotion + 
           YearsWithCurrManager, caseStudyModified)
summary(fit)


#Eliminate based on level of effect on model
fit = lm(MonthlyIncome~BusinessTravel + 
           JobLevel + JobRole  + PerformanceRating  + YearsSinceLastPromotion, caseStudyModified)
summary(fit)


#Eliminated a second time based on level of effect on model
fit = lm(MonthlyIncome~BusinessTravel + 
           JobLevel + JobRole  + YearsSinceLastPromotion, caseStudyModified)
summary(fit)
mse<-mean(residuals(fit)^2)
rmse<-sqrt(mse)
rmse
prediction = data.frame(caseStudy$ID,predict(fit))
colnames(prediction)<-c('ID','MonthlyIncome')
prediction
write.csv(prediction,"/Users/ZacharyHarris/Desktop/untitled folder\\Case2PredictionsXXXXAttrition.csv", row.names = FALSE)
#Line above will save predictions based on the values that were on the original dataset
#For example, if you want to see what it estimated from your own set, this would be those values.




#Loading dataset without salary values to test the model
nosalary<-read.csv('/Users/ZacharyHarris/Desktop/MS Data Science/MSDS_6306_Doing-Data-Science-Master/Unit 14 and 15 Case Study 2/CaseStudy2CompSet No Salary.csv')

#Preparing data set to work with my parameters. We made qualitative variables switches.
#So, we have to do the same thing here.

#BusinessTravel - 
nosalary$BusinessTravel[nosalary$BusinessTravel=="Non-Travel"]<-0
nosalary$BusinessTravel[nosalary$BusinessTravel=="Travel_Frequently"]<-1
nosalary$BusinessTravel[nosalary$BusinessTravel=="Travel_Rarely"]<-2

#Department - 
nosalary$Department[nosalary$Department=="Sales"]<-0
nosalary$Department[nosalary$Department=="Human Resources"]<-1
nosalary$Department[nosalary$Department=="Research & Development"]<-2

#EducationField - 
nosalary$EducationField[nosalary$EducationField=="Human Resources"]<-0
nosalary$EducationField[nosalary$EducationField=="Technical Degree"]<-1
nosalary$EducationField[nosalary$EducationField=="Medical"]<-2
nosalary$EducationField[nosalary$EducationField=="Life Sciences"]<-3
nosalary$EducationField[nosalary$EducationField=="Other"]<-4
nosalary$EducationField[nosalary$EducationField=="Marketing"]<-5

#Gender - 
nosalary$Gender[nosalary$Gender=="Female"]<-0
nosalary$Gender[nosalary$Gender=="Male"]<-1

#JobRole - 
nosalary$JobRole[nosalary$JobRole=="Sales Representative"]<-0
nosalary$JobRole[nosalary$JobRole=="Human Resources"]<-1
nosalary$JobRole[nosalary$JobRole=="Lab Technician"]<-2
nosalary$JobRole[nosalary$JobRole=="Laboratory Technician"]<-2
nosalary$JobRole[nosalary$JobRole=="Research Scientist"]<-3
nosalary$JobRole[nosalary$JobRole=="Sales Executive"]<-4
nosalary$JobRole[nosalary$JobRole=="Manufacturing Director"]<-5
nosalary$JobRole[nosalary$JobRole=="Healthcare Representative"]<-6
nosalary$JobRole[nosalary$JobRole=="Research Director"]<-7
nosalary$JobRole[nosalary$JobRole=="Manager"]<-8

#MaritalStatus - 
nosalary$MaritalStatus[nosalary$MaritalStatus=="Divorced"]<-0
nosalary$MaritalStatus[nosalary$MaritalStatus=="Single"]<-1
nosalary$MaritalStatus[nosalary$MaritalStatus=="Married"]<-2

#OverTime - 
nosalary$OverTime[nosalary$OverTime=="No"]<-0
nosalary$OverTime[nosalary$OverTime=="Yes"]<-1


#Using model to predict monthly income
prediction_final = data.frame(nosalary$ID,predict(fit, newdata = nosalary))
colnames(prediction_final)<-c('ID','MonthlySalary')
write.csv(prediction_final,"/Users/ZacharyHarris/Desktop/ZacharyHarris_Case2PredictionsMonthlyIncome.csv", row.names = FALSE)
