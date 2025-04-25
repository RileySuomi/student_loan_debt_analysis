library(shiny)
library(tidyverse)
library(readxl)
library(openintro)
library(ggplot2)

college_aid_2000_2022 <- read_excel("college aid 2000-2022.xlsx", skip = 2)
college_aid <- college_aid_2000_2022 |>
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

different_aid <- college_aid |>
  select(year, type, level, avg_federal_grants_award, avg_state_local_grants_award, avg_inst_grants_award, avg_student_loans_award, avg_federal_grants_const, avg_state_local_grants_const, avg_inst_grants_const, avg_student_loans_const) |>
  pivot_longer(
    cols = -c(type, level, year),
    names_to    = c("aidtype", "currency"),
    names_pattern = "avg_(.*)_(award|const)$") |>
  mutate(aidtype = recode(aidtype,
                          federal_grants        = "Federal grants",
                          state_local_grants    = "State/local grants",
                          inst_grants           = "Institutional grants",
                          student_loans         = "Student loans"
  ),
  currency = factor(
    recode(currency,
           award = "Current Dollars",
           const = "Constant (2022-23) Dollars"
    ),
    levels = c("Current Dollars", "Constant (2022-23) Dollars")
  ),
  year = factor(year, levels = unique(year))
  )

ui <- fluidPage(
  titlePanel("Interactive Grants & Loans Explorer"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId  = "type",
        label    = "Institution Control:",
        choices  = unique(different_aid$type),
        selected = "All institutions"
      ),
      selectInput(
        inputId  = "year_sel",
        label    = "Academic Year(s):",
        choices  = levels(different_aid$year),
        selected = levels(different_aid$year),
        multiple = TRUE,
        selectize = TRUE
      )
    ),
    mainPanel(
      plotOutput("aidPlot", height = "600px")
    )
  )
)

graph2 <- function(input, output, session) {
  filtered_data <- reactive({
    req(input$type, input$year_sel)
    different_aid |>
      filter(type %in% input$type,
             year %in% input$year_sel)
  })
  output$aidPlot <- renderPlot({
    plot_df <- filtered_data()
    req(nrow(plot_df) > 0)
    
    ggplot(plot_df, aes(x = year, y = value, fill = aidtype)) +
      geom_col(position = "dodge") +
      facet_wrap(~currency, ncol = 2, scales = "free_y") +
      labs(
        x     = "Academic Year",
        y     = "Average Award Amount ($)",
        fill  = "Aid Type",
        title = glue::glue("Grants & Loans for {input$type}"),
        subtitle = if (length(input$year_sel)==length(unique(different_aid$year))) {
          "2000–01 through 2022–23"
        } else {
          paste(input$year_sel, collapse = ", ")
        }
      ) +
      theme_minimal(base_size = 13) +
      theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        strip.text = element_text(face = "bold")
      )
  })
}
shinyApp(ui, graph2)
