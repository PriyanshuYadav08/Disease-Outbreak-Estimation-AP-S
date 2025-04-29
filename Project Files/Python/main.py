import numpy as np
from data_processing import load_data
from model import train_svm, train_linear_regression
from visualize import plot_predictions

def main():
    # Load the dataset
    X_train, X_test, y_train, y_test = load_data()

    # Train the models
    svm_model = train_svm(X_train, y_train)
    lr_model = train_linear_regression(X_train, y_train)

    # Plot predictions on test set
    plot_predictions(svm_model, lr_model, X_test, y_test)

    # ---------------- Predict Future 10 Days ----------------
    last_day = X_train['days'].max()
    print(f"\nLast day in data: {last_day}")

    future_days = np.arange(last_day + 1, last_day + 11).reshape(-1, 1)

    future_svm_pred = svm_model.predict(future_days)
    future_lr_pred = lr_model.predict(future_days)

    print("\nPredictions for the next 10 days (SVM):")
    for day, pred in zip(range(last_day + 1, last_day + 11), future_svm_pred):
        print(f"Day {day}: {int(pred)} cases (SVM)")

    print("\nPredictions for the next 10 days (Linear Regression):")
    for day, pred in zip(range(last_day + 1, last_day + 11), future_lr_pred):
        print(f"Day {day}: {int(pred)} cases (Linear Regression)")

if __name__ == "__main__":
    main()