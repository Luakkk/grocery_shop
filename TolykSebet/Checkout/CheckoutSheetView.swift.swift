import SwiftUI

struct CheckoutSheetView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @Binding var isPresented: Bool
    @Binding var retryCheckout: Bool

    @State private var selectedDelivery = "Select Method"
    @State private var selectedPayment = "Select Payment"
    @State private var selectedPromo = "Pick discount"

    @State private var showSuccessSheet = false
    @State private var showFailureSheet = false

    @State private var showDeliverySheet = false
    @State private var showPaymentSheet = false
    @State private var showPromoSheet = false

    var body: some View {
        VStack(spacing: 20) {
            // Заголовок + закрытие
            HStack {
                Text("Checkout")
                    .font(.title3.bold())
                Spacer()
                Button(action: { isPresented = false }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding(6)
                        .background(Color(.systemGray5))
                        .clipShape(Circle())
                }
            }

            // Delivery
            checkoutRow(title: "Delivery", value: selectedDelivery) {
                showDeliverySheet = true
            }

            // Payment
            checkoutRow(title: "Payment", value: selectedPayment) {
                showPaymentSheet = true
            }

            // Promo Code
            checkoutRow(title: "Promo Code", value: selectedPromo) {
                showPromoSheet = true
            }

            // Total Cost
            HStack {
                Text("Total Cost")
                    .font(.body)
                Spacer()
                Text("$\(String(format: "%.2f", cartVM.totalPrice))")
                    .font(.body.bold())
            }
            .padding(.top, 4)

            // Terms
            Text("By placing an order you agree to our **Terms And Conditions**.")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.top, 8)

            // Place Order
            Button(action: {
                // Проверка на незаполненные поля
                if selectedDelivery == "Select Method" || selectedPayment == "Select Payment" || selectedPromo == "Pick discount" {
                    showFailureSheet = true
                } else {
                    showSuccessSheet = true
                }
            }) {
                Text("Place Order")
                    .foregroundColor(.white)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(.top)

            Spacer()
        }
        .padding()
        .background(.white)
        .cornerRadius(20)
        .padding(.top, 8)

        // ✅ Order Success Sheet
        .sheet(isPresented: $showSuccessSheet, onDismiss: {
            cartVM.clearCart()
            isPresented = false
        }) {
            OrderSuccessView()
        }

        // ❌ Order Retry Sheet
        .sheet(isPresented: $showFailureSheet) {
            OrderFailedView(retryCheckout: $retryCheckout)
        }


        // ✅ Pickers
        .sheet(isPresented: $showDeliverySheet) {
            SimplePickerView(title: "Delivery", options: ["Standard", "Express", "Pickup"], selection: $selectedDelivery)
        }
        .sheet(isPresented: $showPaymentSheet) {
            SimplePickerView(title: "Payment", options: ["Card", "Cash", "Apple Pay"], selection: $selectedPayment)
        }
        .sheet(isPresented: $showPromoSheet) {
            SimplePickerView(title: "Promo", options: ["10% OFF", "FREESHIP", "STUDENT15"], selection: $selectedPromo)
        }
    }

    @ViewBuilder
    private func checkoutRow(title: String, value: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                Spacer()
                Text(value)
                    .foregroundColor(.gray)
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

