from sklearn.svm import SVR
from sklearn.linear_model import LinearRegression

def train_svm(X_train, y_train):
    svm = SVR(kernel='rbf', C=100, gamma=0.1, epsilon=0.1)
    svm.fit(X_train, y_train)
    return svm

def train_linear_regression(X_train, y_train):
    lr = LinearRegression()
    lr.fit(X_train, y_train)
    return lr