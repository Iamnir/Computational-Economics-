#connect with your drive 
from google.colab import drive
drive.mount('/content/drive')
#read your csv file 
import pandas as pd 
df= pd.read_csv("/content/drive/MyDrive/transliteration_sample.csv")
df.head()
sentences = df['panchayatname'].tolist()
print(sentences)
pip install indic_transliteration -U
from indic_transliteration import sanscript
from indic_transliteration.sanscript import SchemeMap, SCHEMES, transliterate
NewPan = []
for i in range(len(sentences)): 
     NewPan.append(transliterate(sentences[i], sanscript.DEVANAGARI, sanscript.IAST))
df['NewP'] = NewPan
df.head(100)
#Save your dataframe into a csv file 
df.to_csv(r'/content/drive/MyDrive/transliteration_sample - transliteration_sample.csv', index = False)
