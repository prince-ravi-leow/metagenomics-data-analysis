# How to run this script:
# Set working directory to location of metagenomic-data-analysis repo 
# Run in terminal: Rscript meta.R

# Library import
library(dplyr)
library(magrittr)
library(ggplot2)
library(readr)
library(tidyr)
# (Optional: load the entire tidyverse) 
# library(tidyverse)

# CoDa CLR categorisation
resfinder_clr <- read_csv("./resfinder/resfinder_clr.csv")
resfinder_clr %>% 
  pivot_longer(cols = c("CLR(24)", "CLR(25)", "CLR(38)"),
               names_to = "Sample",
               values_to = "CLR") %>% 
  write_csv("./resfinder/resfinder_clr_cat.csv")

# CheckM2 contamination vs. completness plots
## Load csv reports, and merge them into one
plot_df_24 <- read_csv('./checkM2/sample24_EDITED_quality_report.csv') %>% mutate(Sample = "Sample 24") %>% as_tibble()
plot_df_25 <- read_csv('./checkM2/sample25_EDITED_quality_report.csv') %>% mutate(Sample = "Sample 25") %>% as_tibble()
plot_df_38 <- read_csv('./checkM2/sample38_EDITED_quality_report.csv') %>% mutate(Sample = "Sample 38") %>% as_tibble()
full_df <- plot_df_24 %>% full_join(plot_df_25) %>% full_join(plot_df_38)

## Plot all bins, with dRep window
full_df %>% ggplot(aes(x=completeness,y=contamination,colour=Sample)) + 
  scale_color_manual(values = c("Sample 24" = "blue", "Sample 25" = "red", "Sample 38" = "black")) +
  geom_point() +
  geom_rect(aes(xmin = 75, xmax = Inf, ymin = -Inf, ymax = 25), alpha = 0.005, fill = "white") + # dRep settings
  theme_bw() +
  guides(colour=guide_legend(override.aes = list(linetype = c(0,0,0)))) +
  ggtitle("All genome bins after checkM2") 
  theme(legend.position="bottom")

ggsave('./checkM2/all_bins.png')

## Plot dRep bins, along with medium and high quality bins highlighted
full_df %>% 
  filter(completeness>75 & contamination<25) %>% 
  ggplot(aes(x=completeness,y=contamination,colour=Sample)) + 
  scale_color_manual(values = c("Sample 24" = "blue", "Sample 25" = "red", "Sample 38" = "black")) +
  scale_x_continuous(limits=c(75,100)) + 
  scale_y_continuous(limits=c(0,25)) +
  geom_point() +
  geom_rect(aes(xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = 10), alpha = 0.005, fill = "green") + #Medium quality bin
  geom_rect(aes(xmin = 95, xmax = Inf, ymin = -Inf, ymax = 5), alpha = 0.01, fill = "green") + # High quality bin
  guides(colour=guide_legend(override.aes = list(linetype = c(0,0,0)))) + 
  theme_bw() +
  ggtitle('Bins used in dRep', subtitle = 'Lightgreen=MQ bins Darkgreen=HQ bins')

ggsave('./checkM2/dRep_bins.png')

# Gtdb-dk outputs data wrangling
## Load function to perform string split of gtdbtk closest_placement_taxonomy column, and export to csv
taxid_string_split <- function(input_csv,output_csv){
read_tsv(input_csv) %>% 
  select(closest_placement_taxonomy) %>% 
  separate(col = 1,
           into = c("domain", "phylum", "class", "order", "family", "genus", "species"), 
           sep = ";") %>%  
  write_excel_csv(output_csv)
}
## Perform string split 
taxid_string_split('Gtdbtk/24_gtdbtk.bac120.summary.tsv','Gtdbtk/24_gtdbtk_taxid.csv')
taxid_string_split('Gtdbtk/25_gtdbtk.bac120.summary.tsv','Gtdbtk/25_gtdbtk_taxid.csv')
taxid_string_split('Gtdbtk/38_gtdbtk.bac120.summary.tsv','Gtdbtk/38_gtdbtk_taxid.csv')