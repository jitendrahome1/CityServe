//
//  PaymentMethodsView.swift
//  CityServe
//
//  Manage saved payment methods (cards, UPI, wallets, bank accounts)
//  Design Spec: 48_PAYMENT_METHODS.md
//

import SwiftUI
import Combine

struct PaymentMethodsView: View {

    @StateObject private var viewModel = PaymentMethodsViewModel()
    @State private var showAddPayment = false
    @State private var selectedMethodType: PaymentMethodType?

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()

            if viewModel.isEmpty {
                emptyStateView
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: Spacing.lg) {
                        // Cards Section
                        if !viewModel.cards.isEmpty {
                            PaymentSection(title: "💳 Cards") {
                                ForEach(viewModel.cards) { card in
                                    CardItem(
                                        card: card,
                                        isPrimary: card.id == viewModel.primaryCardId,
                                        onEdit: {
                                            Haptics.light()
                                            viewModel.editCard(card)
                                        },
                                        onDelete: {
                                            Haptics.medium()
                                            viewModel.deleteCard(card)
                                        },
                                        onSetDefault: {
                                            Haptics.medium()
                                            viewModel.setPrimaryCard(card)
                                        }
                                    )
                                }
                            }
                        }

                        // UPI Section
                        if !viewModel.upiIds.isEmpty {
                            PaymentSection(title: "💰 UPI") {
                                ForEach(viewModel.upiIds) { upi in
                                    UPIItem(
                                        upi: upi,
                                        isPrimary: upi.id == viewModel.primaryUPIId,
                                        onEdit: {
                                            Haptics.light()
                                            viewModel.editUPI(upi)
                                        },
                                        onDelete: {
                                            Haptics.medium()
                                            viewModel.deleteUPI(upi)
                                        },
                                        onSetDefault: {
                                            Haptics.medium()
                                            viewModel.setPrimaryUPI(upi)
                                        }
                                    )
                                }
                            }
                        }

                        // Wallets Section
                        if !viewModel.wallets.isEmpty {
                            PaymentSection(title: "👛 Wallets") {
                                ForEach(viewModel.wallets) { wallet in
                                    WalletItem(
                                        wallet: wallet,
                                        onRecharge: {
                                            Haptics.medium()
                                            viewModel.rechargeWallet(wallet)
                                        },
                                        onRemove: {
                                            Haptics.medium()
                                            viewModel.removeWallet(wallet)
                                        }
                                    )
                                }
                            }
                        }

                        // Bank Accounts Section
                        if !viewModel.bankAccounts.isEmpty {
                            PaymentSection(title: "🏦 Bank Accounts (Saved for Refunds)") {
                                ForEach(viewModel.bankAccounts) { account in
                                    BankAccountItem(
                                        account: account,
                                        onEdit: {
                                            Haptics.light()
                                            viewModel.editBankAccount(account)
                                        },
                                        onDelete: {
                                            Haptics.medium()
                                            viewModel.deleteBankAccount(account)
                                        }
                                    )
                                }
                            }
                        }

                        // Add Payment Method Button
                        AddPaymentMethodButton(onTap: {
                            Haptics.light()
                            showAddPayment = true
                        })

                        // Security Note
                        securityNote
                    }
                    .padding(.vertical, Spacing.md)
                }
            }
        }
        .navigationTitle("Payment Methods")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    Haptics.light()
                    showAddPayment = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: Spacing.iconMD))
                        .foregroundColor(.primary)
                }
            }
        }
        .confirmationDialog("Add Payment Method", isPresented: $showAddPayment) {
            Button("Add Card") {
                selectedMethodType = .card
            }
            Button("Add UPI") {
                selectedMethodType = .upi
            }
            Button("Add Wallet") {
                selectedMethodType = .wallet
            }
            Button("Add Bank Account") {
                selectedMethodType = .bankAccount
            }
            Button("Cancel", role: .cancel) {}
        }
        .sheet(item: $selectedMethodType) { type in
            AddPaymentMethodView(
                type: type,
                onSave: { method in
                    viewModel.addPaymentMethod(method, type: type)
                    selectedMethodType = nil
                }
            )
        }
        .onAppear {
            viewModel.loadPaymentMethods()
        }
    }

    // MARK: - Subviews

    private var emptyStateView: some View {
        VStack(spacing: Spacing.lg) {
            Spacer()

            EmptyStateView(
                icon: "creditcard",
                title: "No Payment Methods",
                description: "Add a payment method for faster checkout"
            )

            PrimaryButton(
                "Add Payment Method",
                icon: "plus",
                size: .large
            ) {
                Haptics.medium()
                showAddPayment = true
            }
            .padding(.horizontal, Spacing.screenPadding)

            Spacer()
        }
    }

    private var securityNote: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: Spacing.iconSM))
                .foregroundColor(.success)

            Text("All payment information is encrypted and secure")
                .font(.caption)
                .foregroundColor(.textSecondary)
        }
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.success.opacity(0.1))
        .cornerRadius(Spacing.radiusLg)
        .padding(.horizontal, Spacing.screenPadding)
    }
}

// MARK: - Payment Section

struct PaymentSection<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            Text(title)
                .font(.h5)
                .fontWeight(.semibold)
                .foregroundColor(.textPrimary)
                .padding(.horizontal, Spacing.screenPadding)

            VStack(spacing: Spacing.md) {
                content
            }
            .padding(.horizontal, Spacing.screenPadding)
        }
    }
}

// MARK: - Card Item

struct CardItem: View {
    let card: SavedCard
    let isPrimary: Bool
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onSetDefault: () -> Void

    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.md) {
                Image(systemName: "creditcard.fill")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(card.cardType.color)

                Text("•••• \(card.last4Digits)")
                    .font(.h5)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Spacer()

                Text(card.cardType.displayName)
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(.textSecondary)

                if isPrimary {
                    Image(systemName: "star.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.secondary)
                }
            }

            HStack {
                Text("Expires: \(card.expiryMonth)/\(card.expiryYear)")
                    .font(.caption)
                    .foregroundColor(.textSecondary)

                Spacer()
            }

            Text(card.cardholderName)
                .font(.caption)
                .foregroundColor(.textSecondary)

            Divider()

            HStack(spacing: Spacing.md) {
                Button(action: onEdit) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "pencil")
                            .font(.system(size: Spacing.iconXS))
                        Text("Edit")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.primary)
                }

                Button(action: { showDeleteConfirmation = true }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "trash")
                            .font(.system(size: Spacing.iconXS))
                        Text("Delete")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.error)
                }

                Spacer()

                if !isPrimary {
                    Button(action: onSetDefault) {
                        Text("Set Default")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(isPrimary ? Color.secondary : Color.divider, lineWidth: isPrimary ? 2 : 1)
        )
        .alert("Delete Card", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to remove this card?")
        }
    }
}

// MARK: - UPI Item

struct UPIItem: View {
    let upi: SavedUPI
    let isPrimary: Bool
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onSetDefault: () -> Void

    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.md) {
                Image(systemName: "apps.iphone")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.primary)

                Text(upi.upiId)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Spacer()

                if isPrimary {
                    Image(systemName: "star.fill")
                        .font(.system(size: Spacing.iconSM))
                        .foregroundColor(.secondary)
                }
            }

            if upi.isVerified {
                HStack(spacing: Spacing.xxs) {
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: Spacing.iconXS))
                        .foregroundColor(.success)
                    Text("Verified UPI ID")
                        .font(.caption)
                        .foregroundColor(.success)
                }
            }

            Text(upi.provider)
                .font(.caption)
                .foregroundColor(.textSecondary)

            Divider()

            HStack(spacing: Spacing.md) {
                Button(action: onEdit) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "pencil")
                            .font(.system(size: Spacing.iconXS))
                        Text("Edit")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.primary)
                }

                Button(action: { showDeleteConfirmation = true }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "trash")
                            .font(.system(size: Spacing.iconXS))
                        Text("Delete")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.error)
                }

                Spacer()

                if !isPrimary {
                    Button(action: onSetDefault) {
                        Text("Set Default")
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(isPrimary ? Color.secondary : Color.divider, lineWidth: isPrimary ? 2 : 1)
        )
        .alert("Delete UPI", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to remove this UPI ID?")
        }
    }
}

// MARK: - Wallet Item

struct WalletItem: View {
    let wallet: SavedWallet
    let onRecharge: () -> Void
    let onRemove: () -> Void

    @State private var showRemoveConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack {
                Text(wallet.name)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Spacer()
            }

            HStack(spacing: Spacing.xxs) {
                Text("Balance:")
                    .font(.caption)
                    .foregroundColor(.textSecondary)
                Text("₹\(wallet.balance)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.success)
            }

            Text(wallet.linkedPhone)
                .font(.caption)
                .foregroundColor(.textSecondary)

            Divider()

            HStack(spacing: Spacing.md) {
                Button(action: onRecharge) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "plus.circle")
                            .font(.system(size: Spacing.iconXS))
                        Text("Recharge")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.primary)
                }

                Button(action: { showRemoveConfirmation = true }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "trash")
                            .font(.system(size: Spacing.iconXS))
                        Text("Remove")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.error)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(Color.divider, lineWidth: 1)
        )
        .alert("Remove Wallet", isPresented: $showRemoveConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Remove", role: .destructive) {
                onRemove()
            }
        } message: {
            Text("Are you sure you want to unlink this wallet?")
        }
    }
}

// MARK: - Bank Account Item

struct BankAccountItem: View {
    let account: SavedBankAccount
    let onEdit: () -> Void
    let onDelete: () -> Void

    @State private var showDeleteConfirmation = false

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            HStack(spacing: Spacing.md) {
                Image(systemName: "building.columns.fill")
                    .font(.system(size: Spacing.iconSM))
                    .foregroundColor(.primary)

                Text("\(account.bankName) - ••••\(account.last4Digits)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.textPrimary)

                Spacer()
            }

            Text(account.accountHolderName)
                .font(.caption)
                .foregroundColor(.textSecondary)

            Divider()

            HStack(spacing: Spacing.md) {
                Button(action: onEdit) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "pencil")
                            .font(.system(size: Spacing.iconXS))
                        Text("Edit")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.primary)
                }

                Button(action: { showDeleteConfirmation = true }) {
                    HStack(spacing: Spacing.xxs) {
                        Image(systemName: "trash")
                            .font(.system(size: Spacing.iconXS))
                        Text("Delete")
                            .font(.caption)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.error)
                }
            }
        }
        .padding(Spacing.md)
        .background(Color.surface)
        .cornerRadius(Spacing.radiusLg)
        .overlay(
            RoundedRectangle(cornerRadius: Spacing.radiusLg)
                .stroke(Color.divider, lineWidth: 1)
        )
        .alert("Delete Bank Account", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to remove this bank account?")
        }
    }
}

// MARK: - Add Payment Method Button

struct AddPaymentMethodButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: Spacing.iconMD))
                    .foregroundColor(.primary)

                Text("Add Payment Method")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(Spacing.md)
            .background(Color.primary.opacity(0.1))
            .cornerRadius(Spacing.radiusLg)
            .overlay(
                RoundedRectangle(cornerRadius: Spacing.radiusLg)
                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.primary)
            )
        }
        .padding(.horizontal, Spacing.screenPadding)
    }
}

// MARK: - Add Payment Method View (Placeholder)

struct AddPaymentMethodView: View {
    let type: PaymentMethodType
    let onSave: (String) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: Spacing.lg) {
                Spacer()

                Text("Add \(type.displayName)")
                    .font(.h3)
                    .foregroundColor(.textPrimary)

                Text("This form will integrate with Razorpay SDK")
                    .font(.body)
                    .foregroundColor(.textSecondary)
                    .multilineTextAlignment(.center)

                // TODO: Implement actual payment method forms
                PrimaryButton("Save", size: .large) {
                    onSave("mock_id")
                    dismiss()
                }
                .padding(.horizontal, Spacing.screenPadding)

                Spacer()
            }
            .navigationTitle("Add \(type.displayName)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

// MARK: - Data Models

struct SavedCard: Identifiable {
    let id: String
    let last4Digits: String
    let cardType: CardType
    let expiryMonth: String
    let expiryYear: String
    let cardholderName: String
}

struct SavedUPI: Identifiable {
    let id: String
    let upiId: String
    let provider: String
    let isVerified: Bool
}

struct SavedWallet: Identifiable {
    let id: String
    let name: String
    let balance: String
    let linkedPhone: String
}

struct SavedBankAccount: Identifiable {
    let id: String
    let bankName: String
    let last4Digits: String
    let accountHolderName: String
}

enum CardType {
    case visa
    case mastercard
    case amex
    case rupay

    var displayName: String {
        switch self {
        case .visa: return "VISA"
        case .mastercard: return "Mastercard"
        case .amex: return "Amex"
        case .rupay: return "RuPay"
        }
    }

    var color: Color {
        switch self {
        case .visa: return .blue
        case .mastercard: return .orange
        case .amex: return .green
        case .rupay: return .purple
        }
    }
}

enum PaymentMethodType: Identifiable {
    case card
    case upi
    case wallet
    case bankAccount

    var id: String { String(describing: self) }

    var displayName: String {
        switch self {
        case .card: return "Card"
        case .upi: return "UPI"
        case .wallet: return "Wallet"
        case .bankAccount: return "Bank Account"
        }
    }
}

// MARK: - View Model

class PaymentMethodsViewModel: ObservableObject {

    @Published var cards: [SavedCard] = []
    @Published var upiIds: [SavedUPI] = []
    @Published var wallets: [SavedWallet] = []
    @Published var bankAccounts: [SavedBankAccount] = []

    @Published var primaryCardId: String?
    @Published var primaryUPIId: String?

    var isEmpty: Bool {
        cards.isEmpty && upiIds.isEmpty && wallets.isEmpty && bankAccounts.isEmpty
    }

    func loadPaymentMethods() {
        // TODO: Load from API/Firebase
        // Mock data
        cards = [
            SavedCard(
                id: "card_1",
                last4Digits: "4242",
                cardType: .visa,
                expiryMonth: "12",
                expiryYear: "25",
                cardholderName: "John Smith"
            ),
            SavedCard(
                id: "card_2",
                last4Digits: "5678",
                cardType: .mastercard,
                expiryMonth: "08",
                expiryYear: "24",
                cardholderName: "John Smith"
            )
        ]

        upiIds = [
            SavedUPI(
                id: "upi_1",
                upiId: "john@paytm",
                provider: "Paytm",
                isVerified: true
            ),
            SavedUPI(
                id: "upi_2",
                upiId: "9876543210@ybl",
                provider: "PhonePe",
                isVerified: true
            )
        ]

        wallets = [
            SavedWallet(
                id: "wallet_1",
                name: "Paytm Wallet",
                balance: "1,250",
                linkedPhone: "+91 98765 43210"
            ),
            SavedWallet(
                id: "wallet_2",
                name: "Mobikwik",
                balance: "500",
                linkedPhone: "+91 98765 43210"
            )
        ]

        bankAccounts = [
            SavedBankAccount(
                id: "bank_1",
                bankName: "HDFC Bank",
                last4Digits: "5678",
                accountHolderName: "John Smith"
            )
        ]

        primaryCardId = "card_1"
        primaryUPIId = "upi_1"
    }

    func addPaymentMethod(_ id: String, type: PaymentMethodType) {
        // TODO: Implement actual add logic
        print("Added \(type.displayName) with ID: \(id)")
        loadPaymentMethods()
    }

    func editCard(_ card: SavedCard) {
        // TODO: Implement edit
        print("Edit card: \(card.id)")
    }

    func deleteCard(_ card: SavedCard) {
        cards.removeAll { $0.id == card.id }
    }

    func setPrimaryCard(_ card: SavedCard) {
        primaryCardId = card.id
    }

    func editUPI(_ upi: SavedUPI) {
        // TODO: Implement edit
        print("Edit UPI: \(upi.id)")
    }

    func deleteUPI(_ upi: SavedUPI) {
        upiIds.removeAll { $0.id == upi.id }
    }

    func setPrimaryUPI(_ upi: SavedUPI) {
        primaryUPIId = upi.id
    }

    func rechargeWallet(_ wallet: SavedWallet) {
        // TODO: Implement wallet recharge
        print("Recharge wallet: \(wallet.id)")
    }

    func removeWallet(_ wallet: SavedWallet) {
        wallets.removeAll { $0.id == wallet.id }
    }

    func editBankAccount(_ account: SavedBankAccount) {
        // TODO: Implement edit
        print("Edit bank account: \(account.id)")
    }

    func deleteBankAccount(_ account: SavedBankAccount) {
        bankAccounts.removeAll { $0.id == account.id }
    }
}

// MARK: - Preview

#Preview("Payment Methods - Light") {
    NavigationStack {
        PaymentMethodsView()
    }
}

#Preview("Payment Methods - Dark") {
    NavigationStack {
        PaymentMethodsView()
    }
    .preferredColorScheme(.dark)
}

#Preview("Payment Methods - Empty") {
    let viewModel = PaymentMethodsViewModel()
    viewModel.cards = []
    viewModel.upiIds = []
    viewModel.wallets = []
    viewModel.bankAccounts = []

    return NavigationStack {
        PaymentMethodsView()
    }
}
