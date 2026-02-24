# 📁 Raw Data Documentation

Due to GitHub's file size limit of 25MB, the primary internal sales dataset is not hosted directly in this repository. 

### 🔗 Source Data Link
You can download the original `.xlsx` file from the **UCI Machine Learning Repository**:
- **Dataset:** [Online Retail II](https://archive.ics.uci.edu/ml/datasets/Online+Retail+II)
- **Direct Download:** [Download .xlsx File](https://archive.ics.uci.edu/ml/machine-learning-databases/00502/online_retail_ii.xlsx)

### 📂 Files in this folder:
1. **`ons_retail_data.csv`**: The external UK market index data (Included in this repo).
2. **`Download_Instructions.txt`**: A reference for the internal sales files.

### ⚙️ How to run the pipeline:
1. Download the `online_retail_ii.xlsx` file from the link above.
2. Place it in this folder (`01_Raw_Data/`).
3. Run the Jupyter Notebook in the `02_Python_Preprocessing/` folder. This will combine the sheets and generate the `cleaned_internal_sales_final.csv` required for the SQL ingestion.
