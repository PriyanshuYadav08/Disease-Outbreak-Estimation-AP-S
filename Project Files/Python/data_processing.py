import pandas as pd
from sklearn.model_selection import train_test_split

def load_data():
    # Load the COVID-19 dataset
    df = pd.read_csv("../../Datasets/time_series_covid-19_confirmed.csv")

    # Filter only for India
    india_df = df[df['Country/Region'] == 'India']

    # Drop unnecessary columns
    india_df = india_df.drop(['Province/State', 'Country/Region', 'Lat', 'Long'], axis=1)

    # Sum across provinces (if there are multiple entries for India)
    india_df = india_df.sum(axis=0)

    # Convert to proper DataFrame
    india_df = pd.DataFrame({
        'date': india_df.index,
        'cases': india_df.values
    })

    # Add 'days' column
    india_df['days'] = range(1, len(india_df) + 1)

    # Features and labels
    X = india_df[['days']]
    y = india_df['cases']

    # Split into training and testing
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

    return X_train, X_test, y_train, y_test