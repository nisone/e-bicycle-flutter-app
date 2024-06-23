function paystackPopUp(publicKey, email, amount, ref, onClosed, callback) {
  const paystack = new PaystackPop();
  return paystack.newTransaction({
    key: publicKey,
    email: email,
    amount: amount,
    ref: ref,
    onSuccess: (response) => {
      callback();
      let message = "Payment complete! Reference: " + response.reference;
      alert(message);
    },
    onCancel: () => {
      alert("Payment canceled");
      onClosed();
    }
  });

}