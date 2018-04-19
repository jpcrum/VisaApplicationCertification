
for (i in 1:length(visaFull)){
  if (visaFull$wage_offer_from_9089[i] <= 100){
    visaFull$pw_unit_of_pay_9089[i] == "Hour"
  } else if (visaFull$wage_offer_from_9089[i] > 100 & visaFull$wage_offer_from_9089[i] <=){
    visaFull$pw_unit_of_pay_9089[i] = visaFull$pw_unit_of_pay_9089[i] * 52
  } else if (visaFull$wage_offer_from_9089[i] == "Bi-Weekly"){
    visaFull$pw_unit_of_pay_9089[i] = visaFull$pw_unit_of_pay_9089[i] * 26
  } else if (visaFull$wage_offer_from_9089[i] == "Week"){
    visaFull$pw_unit_of_pay_9089[i] = visaFull$pw_unit_of_pay_9089[i] * 52
  } else if (visaFull$wage_offer_from_9089[i] == "Month"){
    visaFull$pw_unit_of_pay_9089[i] = visaFull$pw_unit_of_pay_9089[i] * 12
  } else if (visaFull$wage_offer_from_9089[i] == "Year") {
    visaFull$pw_unit_of_pay_9089[i] = visaFull$pw_unit_of_pay_9089[i]
  }
}





for (i in 1:length(visaFull)){
  if (visaFull$pw_unit_of_pay_9089[i] == "Hour"){
    visaFull$wage_offer_from_9089[i] = visaFull$wage_offer_from_9089[i] * 40 * 52
  } else if (visaFull$pw_unit_of_pay_9089[i] == "Week"){
    visaFull$wage_offer_from_9089[i] = visaFull$wage_offer_from_9089[i] * 52
  } else if (visaFull$pw_unit_of_pay_9089[i] == "Bi-Weekly"){
    visaFull$wage_offer_from_9089[i] = visaFull$wage_offer_from_9089[i] * 26
  } else if (visaFull$pw_unit_of_pay_9089[i] == "Week"){
    visaFull$wage_offer_from_9089[i] = visaFull$wage_offer_from_9089[i] * 52
  } else if (visaFull$pw_unit_of_pay_9089[i] == "Month"){
    visaFull$wage_offer_from_9089[i] = visaFull$wage_offer_from_9089[i] * 12
  } else if (visaFull$pw_unit_of_pay_9089[i] == "Year") {
    visaFull$wage_offer_from_9089[i] = visaFull$wage_offer_from_9089[i]
  }
}




index <- which(visaFull$pw_unit_of_pay_9089 == "hr")
visaFull[index, 'pw_unit_of_pay_9089'] <- "Hour"

index <- which(visaFull$pw_unit_of_pay_9089 == "mth")
visaFull[index, 'pw_unit_of_pay_9089'] <- "Month"

index <- which(visaFull$pw_unit_of_pay_9089 == "wk")
visaFull[index, 'pw_unit_of_pay_9089'] <- "Week"

index <- which(visaFull$pw_unit_of_pay_9089 == "bi")
visaFull[index, 'pw_unit_of_pay_9089'] <- "Bi-Weekly"




```{r}
visa$wage_offer_from_9089 <- as.numeric(visa$wage_offer_from_9089)
visa$wage_offer_to_9089 <- as.numeric(visa$wage_offer_to_9089)

visa$salary <- 0

for (i in 1:nrow(visa)) {
  if (is.na(visa$wage_offer_from_9089[i]) & (is.na(visa$wage_offer_to_9089[i]))){
    is.na(visa$salary[i])
  } else {
    n <- max(visa$wage_offer_from_9089[i], visa$wage_offer_to_9089[i])
    visa$salary[i] <- n
  }
}



modelLogitSign <- glm(case_status ~ class_of_admissionL1 +  class_of_admissionNotinUSA + class_of_admissionJ2 + class_of_admissionTN + class_of_admissionTPS + class_of_admissionR1 + country_of_citizenshipARGENTINA + country_of_citizenshipBANGLADESH + country_of_citizenshipCANADA + country_of_citizenshipCOLOMBIA + country_of_citizenshipHONG_KONG + country_of_citizenshipINDIA + country_of_citizenshipIRAN + country_of_citizenshipJAMAICA + country_of_citizenshipMEXICO + country_of_citizenshipNEPAL + country_of_citizenshipPERU + country_of_citizenshipPHILIPPINES + country_of_citizenshipPOLAND + country_of_citizenshipSOUTH_KOREA + country_of_citizenshipSWEDEN + country_of_citizenshipUNITED_KINGDOM + country_of_citizenshipUNITED_STATES_OF_AMERICA + employer_num_employees + employer_stateMS + employer_stateMT + employer_stateVI + foreign_worker_info_educationAssociates + foreign_worker_info_educationBachelors + foreign_worker_info_educationMasters + foreign_worker_info_educationDoctorate + pw_unit_of_pay_9089Hour + pw_unit_of_pay_9089Month + pw_level_9089Level.II + pw_amount_9089, family=binomial(link='logit'), data=training)

summary(modelLogitSign)




```

visa_full_small_companies <- visa_full %>% filter(employer_num_employees <= 10000)

visa_full_medium_companies <- visa_full %>% filter(employer_num_employees > 10000 & employer_num_employees <= 100000)

qplot(visa_full_medium_companies$employer_num_employees, geom = "histogram", binwidth = 3000, fill = visa_full_medium_companies$case_status, col = I("grey"), xlab = "Salary", ylab = "Total Visa Applications", main = "Case Status By Salary") + scale_fill_discrete("Case Status") 

visa_full_large_companies <- visa_full %>% filter(employer_num_employees > 100000 & employer_num_employees < 1000000)

qplot(visa_full_large_companies$employer_num_employees, geom = "histogram", binwidth = 10000, fill = visa_full_large_companies$case_status, col = I("grey"), xlab = "Salary", ylab = "Total Visa Applications", main = "Case Status By Salary") + scale_fill_discrete("Case Status") 