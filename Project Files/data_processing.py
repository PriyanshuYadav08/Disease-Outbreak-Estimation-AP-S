import pandas as pd
from sklearn.model_selection import train_test_split

def load_data():
    # You can replace this with your actual dataset
    # For example: df = pd.read_csv("corona_cases.csv")

    # Example dummy data
    df = pd.DataFrame({
        'days': range(1, 101),
        'cases': [i + (i**1.5)*0.01 for i in range(1, 101)]
    })

    X = df[['days']]
    y = df['cases']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    return X_train, X_test, y_train, y_test