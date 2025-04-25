library(shiny)
library(tidyverse)
library(readxl)
library(openintro)
library(ggplot2)

college_aid <- read_excel("college aid 2000-2022.xlsx", skip = 2)
college_aid <- college_aid |>
  rename(Year = `Control and level of institution, and year`)

college_aid <- college_aid |>
  mutate(Type = ifelse(is.na(`Number enrolled`), Year, NA)) |>
  fill(Type) |>
  mutate(Type = str_squish(Type), 
         Year = str_squish(Year)) |>
  filter(!is.na(`Number enrolled`)) |>
  mutate(Level = ifelse(Type %in% c("2-year", "4-year"), Type, "Both")) |>
  select(Type, Level, everything()) |>
  mutate(Type = ifelse(Type %in% c("2-year", "4-year"), NA, Type)) |>
  fill(Type)

names(college_aid)<- c(
  "type",
  "level",
  "year",
  "num_of_enrolled",
  "num_awarded_aid",
  "pct_sutdents_awarded_aid",
  "pct_with_fed_grants", 
  "pct_with_state_local_grants", 
  "pct_with_institutional_grant", 
  "pct_student_loans",
  "avg_federal_grants_award", 
  "avg_state_local_grants_award", 
  "avg_inst_grants_award", 
  "avg_student_loans_award",
  "avg_federal_grants_const", 
  "avg_state_local_grants_const", 
  "avg_inst_grants_const", 
  "avg_student_loans_const"
)

college_aid <- college_aid |>
  mutate(across(
    .cols = num_of_enrolled:avg_student_loans_const,
    .fns  = ~ round(as.numeric(.), 3)
  ))

aid_group_long <- college_aid |>
  pivot_longer(
    cols = c(avg_federal_grants_award, 
             avg_state_local_grants_award, 
             avg_inst_grants_award, 
             avg_student_loans_award),
    values_to = "avg_award",
    names_to = "aid_type") |>
  mutate(
    aid_type = recode(aid_type,
                      avg_federal_grants_award   = "Federal Grants",
                      avg_state_local_grants_award = "State/Local Grants",
                      avg_inst_grants_award = "Institutional Grants",
                      avg_student_loans_award = "Student Loans"),
    year = factor(year, levels = unique(year))) |>
  select(type, level, year, aid_type, avg_award)

ui <- fluidPage(
  titlePanel("Average Aid Awards by Aid Type"),
  sidebarLayout(
    sidebarPanel(
      selectInput("type", "Institution Type:",
                  choices = unique(aid_group_long$type),
                  selected = "All institutions"),
      selectInput("level", "Program Duration:",
                  choices = c("Both", "2-year", "4-year"),
                  selected = "Both")
    ),
    mainPanel(
      plotOutput("aidPlot")
    )
  )
)

graph1 <- function(input, output, session) {
  filtered_data <- reactive({
    aid_group_long %>%
      filter(type == input$type, level == input$level)
  })
  
  output$aidPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = year, y = avg_award, group = level, color = level)) +
      geom_line(size = 0.8) +
      geom_point(size = 2) +
      facet_wrap(~ aid_type, scales = "free_y") +
      scale_color_brewer(palette = "Set2") +
      labs(
        title = paste(input$type, "–", input$level),
        x     = "Academic Year",
        y     = "Average Award ($)",
        color = "Program Duration"
      ) +
      theme_minimal() +
      theme(
        axis.text.x = element_text(angle = 80, hjust = 1),
        plot.title  = element_text(face = "bold")
      )
  })
}

shinyApp(ui, graphs)


