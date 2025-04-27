import matplotlib.pyplot as plt

def plot_predictions(svm_model, lr_model, X_test, y_test):
    y_pred_svm = svm_model.predict(X_test)
    y_pred_lr = lr_model.predict(X_test)

    plt.figure(figsize=(10, 6))
    plt.scatter(X_test, y_test, color='black', label='Actual Data')
    plt.plot(X_test, y_pred_svm, color='red', label='SVM Predictions')
    plt.plot(X_test, y_pred_lr, color='blue', label='Linear Regression Predictions')
    plt.xlabel('Days')
    plt.ylabel('Cases')
    plt.title('Corona Cases Prediction')
    plt.legend()
    plt.show()