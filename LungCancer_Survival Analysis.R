rm(list = ls())
library(survminer)
install.packages("survminer")

df <- read.table("LungCancer.txt")
str(df)
View(df)
attach(df)
#Columns names
colnames(df) <- c("Treatment","Cell_type","Survival","Status","Karnofsky_score"
                  ,"Diagnosis_Time","Age","Prior_chemotherapy")

attach(df)

# Descriptive statistics
length(unique(Survival))                 # Count of unique values in the Time Column
unique(Survival)                         # 20 unique times in the sample: 1-28 
summary(Survival)
table(Status)
hist(Karnofsky_score)
hist(Survival)
table(UnempIns)



install.packages("survival")
library(survival)
km1 <- survfit(Surv(Survival, Status) ~ 1)      
summary(km1)
plot(km1, xlab="Time", ylab="Survival Probability")
ggsurvplot_list(km1,
                data = df,
                risk.table = FALSE,
                pval = TRUE,
                break.time.by = 500,
                ggtheme = theme_minimal(),
                risk.table.y.text.col = FALSE,
                risk.table.y.text = FALSE)
require("survival")
# Kaplan-Meier non-parametric analysis by group
km2 <- survfit(Surv(Survival, Status) ~ Prior_chemotherapy)
summary(km2)
plot(km2, xlab="Time", ylab="Survival Probability")
help(??ggsurvplot)
ggsurvplot(km2, data = df)

# Nelson-Aalen non-parametric analysis
na <- survfit(coxph(Surv(Survival, Status) ~ 1), type="aalen")
summary(na)
plot(na, xlab="Time", ylab="Survival Probability")

# Cox proportional hazard model - coefficients and hazard rates
cox <- coxph(Surv(Survival, Status) ~ as.factor(Treatment)+ Age + Diagnosis_Time+Karnofsky_score +as.factor(Prior_chemotherapy), method="breslow")
summary(cox)
df$Cell_type <- relevel(df$Cell_type, 1)
----------
#models with treatment,Age,Diognosis time 
cox <- coxph(Surv(Survival, Status) ~  Age+ as.factor(Treatment) + Diagnosis_Time, method="breslow")
summary(cox)
cox <- coxph(Surv(Survival, Status) ~ as.factor(Treatment)+ Age + Diagnosis_Time, method="breslow")

# Exponential, Weibull, and log-logistic parametric model coefficients
exp <- survreg(Surv(Survival, Status) ~ as.factor(Treatment) + Age + Diagnosis_Time, dist="exponential")
summary(exp)

weibull <- survreg(Surv(Survival, Status) ~ as.factor(Treatment) + Age + Diagnosis_Time, dist="weibull")
summary(weibull)

loglogistic <- survreg(Surv(Survival, Status) ~ as.factor(Treatment) + Age + Diagnosis_Time, dist="loglogistic")
summary(loglogistic)

library(stargazer)
stargazer(cox, exp, weibull, loglogistic, type="text")



cox <- coxph(Surv(Survival, Status) ~ as.factor(Treatment)+as.factor(Cell_type)+ Age + Diagnosis_Time+Karnofsky_score +as.factor(Prior_chemotherapy), method="breslow")
summary(cox)
df$Cell_type <- relevel(df$Cell_type, 1)

cox <- coxph(Surv(Survival, Status) ~ Treatment+as.factor(Cell_type)+ Age + Diagnosis_Time, method="breslow")
summary(cox)
df$Cell_type <- relevel(df$Cell_type, 1)

----------------
# models with all variables
  
cox <- coxph(Surv(Survival, Status) ~ as.factor(Treatment)+ Age + Diagnosis_Time +as.factor(Prior_chemotherapy), method="breslow")
summary(cox)

# Exponential, Weibull, and log-logistic parametric model coefficients
exp <- survreg(Surv(Survival, Status) ~ as.factor(Treatment)+as.factor(Cell_type)+ Age + Diagnosis_Time+Karnofsky_score +as.factor(Prior_chemotherapy), dist="exponential")
summary(exp)

weibull <- survreg(Surv(Survival, Status) ~ as.factor(Treatment)+as.factor(Cell_type)+ Age + Diagnosis_Time+Karnofsky_score +as.factor(Prior_chemotherapy), dist="weibull")
summary(weibull)

loglogistic <- survreg(Surv(Survival, Status) ~ as.factor(Treatment)+as.factor(Cell_type)+ Age + Diagnosis_Time +as.factor(Prior_chemotherapy), dist="loglogistic")
summary(loglogistic)
library(stargazer)
stargazer(cox, exp, weibull, loglogistic, type="text")




