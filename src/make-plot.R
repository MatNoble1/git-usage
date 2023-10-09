library(ggplot2)

#This isn't a full file path, just need the file path from the working directory
#Makes code be non-computer specific
sods_data <- read.csv("data/stackoverflow-git-data.csv")

#Make a plot of git usage over time
g <- ggplot (
  data = sods_data ,
  mapping = aes(x = year, y = percentage)) +
  geom_point() +
  geom_smooth(method = "lm", colour = "darkgrey") +
  geom_text(
    aes(x = 2020, y = 82.8, label = "only GitHub") ,
    size = 3,
    nudge_x = 0.2 ,
    nudge_y = -6) +
  labs(
    x= "Year",
    y = "Percentage who used git") +
  ylim(c(0 ,100)) +
  theme_bw()
ggsave(filename = "out/git-usage.png",
         plot = g ,
         height = 7.4 ,
         width = 10.5 ,
         units = "cm")
sink(file = "out/regression-summary.txt") #tells it to put the output into the folder called 'out', and name the file regression-summary.txt
summary(lm(percentage ~ year, data = sods_data) )
sink()

#Tells it to put the output of sessioninfo command (version info etc.) into out folder, and call the file package-versions.txt 
sink(file = "out/package-versions.txt")
sessionInfo()
sink()
