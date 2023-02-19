import streamlit as st
import pandas as pd
import numpy as np

#### loading the dataset
from sklearn.datasets import load_breast_cancer
breast_cancer = load_breast_cancer(as_frame=True)
breast_cancer_df = pd.concat((breast_cancer["data"], breast_cancer["target"]), axis=1)
breast_cancer_df["target"] = [breast_cancer.target_names[val] for val in breast_cancer_df["target"]]

#### set the width page and the title
st.set_page_config(layout="wide")
st.markdown("Breath Cancer Stats")


import matplotlib.pyplot as plt 


### Scatter Chart
# Select box for x and y axis
import seaborn as sns
st.sidebar.markdown("Scatter Chart")
st.sidebar.markdown("You can choose which data who you want to see in each axis")
selectbox_x = st.sidebar.selectbox( "Select a value for x:", breast_cancer_df.columns.tolist() )
selectbox_y = st.sidebar.selectbox( "Select a value for y:", breast_cancer_df.columns.tolist() )
st.sidebar.write(f"You selected {selectbox_x} for x and {selectbox_y} for y.")

#Scatter Plot  
sns.relplot(x=selectbox_x,y=selectbox_y, data=breast_cancer_df)
st.pyplot()
st.set_option('deprecation.showPyplotGlobalUse', False)


#### Side by side bar chart
st.sidebar.markdown("Bar Chart")
#Create a multi select to choose which measurments to compare
st.sidebar.markdown("You can select and compare four datas")
options = st.sidebar.multiselect('Which measurement are you interested to see?', breast_cancer_df.columns.tolist(),["mean radius", "mean texture", "mean perimeter", "area error"])
st.sidebar.write('You have selected:', options)
#Create an intermediate dataframe
avg_breast_cancer_df = breast_cancer_df.groupby("target").mean()
#Create the bar chart
bar_fig = plt.figure(figsize=(8,7))
bar_ax = bar_fig.add_subplot(111)
avg_breast_cancer_df[options].plot.bar(ax=bar_ax)
bar_ax.set_title('Comparison of Selected Measurements')
bar_ax.set_xlabel('Samples')
bar_ax.set_ylabel('Mean')
st.pyplot(bar_fig)
st.set_option('deprecation.showPyplotGlobalUse', False)


#### Histogram
st.sidebar.markdown("Histogram")
#Create a multi select
options_2 = st.sidebar.multiselect('Which data are you interested to see?', breast_cancer_df.columns.tolist(),["mean radius","mean texture"])
st.sidebar.write('You have selected:', options_2)
#Create the histogram
hist_fig = plt.figure(figsize=(8,7))
hist_ax = hist_fig.add_subplot(111)
plt.hist(breast_cancer_df[options_2], bins=50, alpha=0.7)
hist_ax.set_xlabel('Value')
hist_ax.set_ylabel('Frequency')
hist_ax.set_title('Histogram of {}'.format(', '.join(options_2)))
st.pyplot(hist_fig)


####Hexbin chart
st.sidebar.markdown("Hexbin chart")
#Create the boxes for x and y axis
selectbox_x_2 = st.sidebar.selectbox( "Select a value for x axis in hexbin:", breast_cancer_df.columns.tolist() )
selectbox_y_2 = st.sidebar.selectbox( "Select a value for y axis in hexbin:", breast_cancer_df.columns.tolist() )
st.sidebar.write(f"You selected {selectbox_x} for x and {selectbox_y} for y.")
#Create the hexbin chart
hexbin_fig = plt.figure(figsize=(8,7))
hexbin_ax = hexbin_fig.add_subplot(111)
plt.hexbin(x=selectbox_x_2, y=selectbox_y_2, data=breast_cancer_df, reduce_C_function=np.mean, gridsize=25, ax=hexbin_ax, title="Concentration of Measurements")
st.pyplot(hexbin_ax)