
return {
    s({trig="plot_confusion_matrix", desc="Confusion matrix"}, fmt ([[
        from sklearn.metrics import ConfusionMatrixDisplay

        def plot_confusion_matrix(cm, labels):
          disp = ConfusionMatrixDisplay(confusion_matrix=cm, display_labels=labels)
          disp.plot(cmap="Blues", values_format=".2f", colorbar=False)
          plt.title("Normalized confusion matrix", fontweight="bold")
    ]], {})),

}
