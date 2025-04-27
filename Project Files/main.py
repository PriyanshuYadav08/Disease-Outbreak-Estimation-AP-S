from data_processing import load_data
from model import train_svm, train_linear_regression
from visualize import plot_predictions

def main():
    # Load the dataset
    X_train, X_test, y_train, y_test = load_data()

    # Train the models
    svm_model = train_svm(X_train, y_train)
    lr_model = train_linear_regression(X_train, y_train)

    # Plot the predictions
    plot_predictions(svm_model, lr_model, X_test, y_test)

if __name__ == "__main__":
    main()