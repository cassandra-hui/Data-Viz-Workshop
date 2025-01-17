#############
# Part 2
#############


data("mtcars")
library(ggplot2)

am0 <-subset(mtcars, am == 0)
am1 <-subset(mtcars, am == 1)
mn0 <- round(mean(am0$mpg), 2)
mn1 <- round(mean(am1$mpg), 2)

ggplot(data = mtcars, aes(x = factor(am), y = mpg)) +
  stat_summary(fun.data = mean_cl_boot, geom = "errorbar",
               color = "black", width = 0.3) +
  stat_summary(fun = mean, geom = "point",
               size = 5, color = "black") +
  geom_point(position = position_jitter(width = 0.05), size = 5, pch = 21, color = "black", aes(fill = factor(cyl)), alpha = 0.8) +
  scale_fill_manual(
    values = c("grey80", "grey30", "#6a51a3"),
    labels = c("4" = "Slowest", 
               "6" = "Still Slow", 
               "8" = "Fast but Broke")) +        # Custom legend labels
  scale_x_discrete(labels = c("0" = "Automatic", 
                              "1" = "Manual")) +    # Custom x axis labels
  scale_y_continuous(breaks=c(mn0, mn1))+ # Set axis limits and numbers
  labs(
    x = "Transmission Type",
    y = "Miles per Gallon") + 
  theme_classic() +
  theme(
    axis.title.x = element_text( size=20, family= "Arial"
                                , vjust=-0.2
                                 ),
    axis.text.x  = element_text( size=16, family= "Arial"),
    axis.title.y = element_text( size=20, family= "Arial"
                                 , vjust=2
                                 ), # vjust is the distance from the text
    axis.text.y  = element_text( size=16, family= "Arial"),
    legend.title = element_blank(),
    legend.position = "bottom")


ggsave("ex1.png", dpi=600)


## Exercise 2

ggplot(data = mtcars, aes(x = wt, y = disp, color = factor(cyl))) +
  geom_smooth(method = "lm", se = FALSE, color = "black", linetype = "dotdash") +
  geom_point(aes(size = hp), alpha = 0.8) +
  scale_color_manual(
    values = c("grey80", "grey30", "#6a51a3"),
    labels = c("4" = "Slowest", 
               "6" = "Still Slow", 
               "8" = "Fast but Broke")) +        # Custom legend labels
  scale_size_continuous(
    breaks = c(100, 200, 300),  # Define specific breaks for horsepower
    labels = c("100 hp", "200 hp", "Rocket Mode"),  # Corresponding labels for the breaks
    range = c(1, 10)) +  # Define the range of point sizes
  theme_classic() +
  labs(
    size = "Horsepower",  # Label for the size scale
    color = "Number of Cylinders",  # Label for the color scale
    x = "Weight (1000 lbs)",
    y = "Displacement (cu. in.)",
    title = "Relationship Between Weight and Displacement",
    subtitle = "Point size indicates horsepower; color indicates number of cylinders"
  ) +
  theme(
    axis.title.x = element_text( size=16, family= "Arial"),
    axis.text.x  = element_text( size=14, family= "Arial"),
    axis.title.y = element_text( size=16, family= "Arial"), 
    axis.text.y  = element_text( size=14, family= "Arial"),
    plot.title = element_text(size=19, family= "Arial")
 )

ggsave("ex2.png", dpi=600)

######################
# Part 3
######################



ggplot(data = mtcars, aes(x= wt, y = mpg, color = factor(cyl))) +
  geom_point(size = 5, alpha = 0.8) +
  scale_color_manual(
    values = c("grey80", "grey30", "#6a51a3"),
    labels = c("4" = "Slowest", 
               "6" = "Still Slow", 
               "8" = "Fast but Broke")) + 
  facet_wrap(~am, labeller = as_labeller(c("0" = "Automatic", "1" = "Manual")))


## Exercise 2

# Add row names as a new column in the mtcars dataset
mtcars$car_name <- rownames(mtcars)

# Prepare data
tmp <- mtcars %>%
  mutate(annotation = case_when(wt > 5  ~ "yes")) 


###


ggplot(data = mtcars, aes(x= wt, y = mpg, color = factor(cyl)), label = rownames(mtcars)) +
  geom_point(size = 5, alpha = 0.8) +
  scale_color_manual(
    values = c("grey80", "grey30", "#6a51a3"),
    labels = c("4" = "Slowest", 
               "6" = "Still Slow", 
               "8" = "Fast but Broke")) +
  facet_wrap(~am, labeller = as_labeller(c("0" = "Automatic", "1" = "Manual"))) +
  geom_text_repel(data = tmp1 %>% filter(annotation == "yes"), 
                  aes(label = car_name),  # Use the new column for labels
                  size = 3) +
  theme_minimal() +
  labs(
    color = "Number of Cylinders",  # Label for the color scale
    x = "Weight (1000 lbs)",
    y = "Miles Per Gallon",
    title = "Relationship Between Weight and MPG"
  ) +
  theme(
    axis.title.x = element_text( size=16, family= "Arial"),
    axis.text.x  = element_text( size=14, family= "Arial"),
    axis.title.y = element_text( size=16, family= "Arial"), 
    axis.text.y  = element_text( size=14, family= "Arial"),
    plot.title = element_text(size=19, family= "Arial")
  )


###

ggplot(data = mtcars, aes(x= wt, y = mpg, color = factor(cyl)), label = rownames(mtcars)) +
  geom_point(size = 5, alpha = 0.8) +
  scale_color_manual(
    values = c("grey80", "grey30", "#6a51a3"),
    labels = c("4" = "Slowest", 
               "6" = "Still Slow", 
               "8" = "Fast but Broke")) +
  facet_wrap(~am, nrow = 2, labeller = labeller(am = as_labeller(c("0" = "Automatic", "1" = "Manual")))) +
  geom_text_repel(data = tmp1 %>% filter(annotation == "yes"), 
                  aes(label = car_name),  # Use the new column for labels
                  size = 3) +
  theme_classic() +
  labs(
    color = "Number of Cylinders",  # Label for the color scale
    x = "Weight (1000 lbs)",
    y = "Miles Per Gallon",
    title = "Relationship Between Weight and MPG"
  ) +
  theme(
    axis.title.x = element_text( size=16, family= "Arial"),
    axis.text.x  = element_text( size=14, family= "Arial"),
    axis.title.y = element_text( size=16, family= "Arial"), 
    axis.text.y  = element_text( size=14, family= "Arial"),
    plot.title = element_text(size=19, family= "Arial")
  )


ggsave("ex3.1.png", dpi=600)

###

ggplot(data = mtcars, aes(x= wt, y = mpg, color = factor(cyl)), label = rownames(mtcars)) +
  geom_point(size = 5, alpha = 0.8) +
  scale_color_manual(
    values = c("grey80", "grey30", "#6a51a3"),
    labels = c("4" = "Slowest", 
               "6" = "Still Slow", 
               "8" = "Fast but Broke")) +
  facet_wrap(~am, nrow = 2, labeller = labeller(am = as_labeller(c("0" = "Automatic", "1" = "Manual")))) +
  geom_text_repel(data = tmp1 %>% filter(annotation == "yes"), 
                  aes(label = car_name),  # Use the new column for labels
                  size = 3,
                  show.legend = FALSE) +                # REMOVE A IN LEGEND
  theme_classic() +
  labs(
    color = "Number of Cylinders",  # Label for the color scale
    x = "Weight (1000 lbs)",
    y = "Miles Per Gallon",
    title = "Relationship Between Weight and MPG"
  ) +
  theme(
    axis.title.x = element_text( size=16, family= "Arial"),
    axis.text.x  = element_text( size=14, family= "Arial"),
    axis.title.y = element_text( size=16, family= "Arial"), 
    axis.text.y  = element_text( size=14, family= "Arial"),
    plot.title = element_text(size=19, family= "Arial")
  )

ggsave("testex3.png", last_plot(), width = 8, dpi = 600)
