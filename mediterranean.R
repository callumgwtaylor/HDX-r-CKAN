origin_deaths <- mediterranean_2 %>%
  select(`#region+origin`, `#affected+dead`) %>%
  group_by(`#region+origin`) %>%
  summarise(sum_deaths = sum(`#affected+dead`, na.rm = TRUE))

origin_deaths[origin_deaths==""] <- NA

origin_deaths <- origin_deaths %>%
  filter(!is.na(`#region+origin`))  %>%
  arrange(desc(sum_deaths))


origin_deaths$`#region+origin` <- as.factor(origin_deaths$`#region+origin`)

origin_deaths_plot <- ggplot(origin_deaths, aes(`#region+origin`, sum_deaths, fill = "#FF0000")) +
  geom_bar(stat = "identity") +
  theme_minimal() + 
  theme(legend.position = "NULL", axis.text.x =element_text(angle = 45, hjust = 1)) +
  labs(y = "Total Deaths Per Month", x = "Time", title = "Monthly Deaths Crossing the Mediterranean from 2014 onwards", subtitle = " ")
origin_deaths_plot