import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import Ridge
from sklearn.preprocessing import PolynomialFeatures
from sklearn.pipeline import make_pipeline

#Data
np.random.seed(0)
n_samples = 100
X = np.sort(10 * np.random.rand(n_samples, 1), axis=0).reshape(-1, 1) #100 el with values in [0, 10)
Y = 1 + np.cos(X).ravel() + 0.25 * np.random.randn(n_samples) #f + random noise
X_Training, X_Test, Y_Training, Y_Test = train_test_split(X, Y, test_size=0.33)
X_range = np.linspace(X.min(), X.max(), 100).reshape(-1, 1)

#Plotting
plt.scatter(X_Training, Y_Training, color="black", label='Training data')
plt.scatter(X_Test, Y_Test, color="red", label='Testing data')
plt.xlabel("x")
plt.ylabel("y")
plt.legend()
plt.title("Data")
plt.show()

def r_pol_reg(weights, alpha):
    #Model
    model = make_pipeline(PolynomialFeatures(weights), Ridge(alpha=alpha))
    model.fit(X_Training, Y_Training)
    score = model.score(X_Test, Y_Test)
    print("Result for w={0} and alpha={1}:".format(weights, alpha), score)
    Y_pred = model.predict(X_range)
    
    #Plotting
    plt.plot(X_range, Y_pred, color="blue", label="f(x)")
    plt.scatter(X_Training, Y_Training, color="black", label='Training data')
    plt.scatter(X_Test, Y_Test, color="red", label='Testing data')
    plt.xlabel("x")
    plt.ylabel("y")
    plt.legend()
    plt.title("P.R. with {0} weights and alpha = {1}. Score: {2}".format(weights, round(alpha, 3), round(score, 3)))
    plt.show()
    return score

alphas = np.linspace(0,1,5)
weights = [3,4,5]
scores = {}
for w in weights:
    for a in alphas:
        scores[(w, a)] = r_pol_reg(w, a)


max_params = max(scores, key=scores.get)
max_score = scores[max_params]

print("Max score:", max_score, " with w =", max_params[0], " and alpha =", max_params[1])
        