//
//  Strings.swift
//  CityServe
//
//  Type-safe Localization Helper
//

import Foundation

/// Type-safe localization helper
/// Usage: Text(Strings.Auth.phoneTitle)
enum Strings {

    // MARK: - Common
    enum Common {
        static let ok = "common.ok".localized
        static let cancel = "common.cancel".localized
        static let done = "common.done".localized
        static let save = "common.save".localized
        static let delete = "common.delete".localized
        static let edit = "common.edit".localized
        static let back = "common.back".localized
        static let next = "common.next".localized
        static let `continue` = "common.continue".localized
        static let confirm = "common.confirm".localized
        static let yes = "common.yes".localized
        static let no = "common.no".localized
        static let close = "common.close".localized
        static let retry = "common.retry".localized
        static let error = "common.error".localized
        static let success = "common.success".localized
        static let loading = "common.loading".localized
        static let search = "common.search".localized
        static let filter = "common.filter".localized
        static let sort = "common.sort".localized
        static let apply = "common.apply".localized
        static let clear = "common.clear".localized
        static let seeAll = "common.seeAll".localized
        static let viewAll = "common.viewAll".localized
        static let submit = "common.submit".localized
        static let send = "common.send".localized
        static let resend = "common.resend".localized
    }

    // MARK: - Authentication
    enum Auth {
        static let welcomeTitle = "auth.welcome.title".localized
        static let welcomeSubtitle = "auth.welcome.subtitle".localized
        static let getStarted = "auth.getStarted".localized
        static let signIn = "auth.signIn".localized
        static let signUp = "auth.signUp".localized
        static let logout = "auth.logout".localized
        static let logoutConfirm = "auth.logout.confirm".localized

        // Phone Login
        static let phoneTitle = "auth.phone.title".localized
        static let phoneSubtitle = "auth.phone.subtitle".localized
        static let phonePlaceholder = "auth.phone.placeholder".localized
        static let sendOtp = "auth.phone.sendOtp".localized
        static let phoneValidationEmpty = "auth.phone.validation.empty".localized
        static let phoneValidationInvalid = "auth.phone.validation.invalid".localized

        // OTP
        static let otpTitle = "auth.otp.title".localized
        static let otpSubtitle = "auth.otp.subtitle".localized
        static let otpPlaceholder = "auth.otp.placeholder".localized
        static func otpResendTimer(_ seconds: Int) -> String {
            String(format: "auth.otp.resend.timer".localized, seconds)
        }
        static let otpResendPrompt = "auth.otp.resend.prompt".localized
        static let otpVerifying = "auth.otp.verifying".localized
        static let otpValidationEmpty = "auth.otp.validation.empty".localized
        static let otpValidationInvalid = "auth.otp.validation.invalid".localized

        // Profile Setup
        static let profileTitle = "auth.profile.title".localized
        static let profileSubtitle = "auth.profile.subtitle".localized
        static let nameLabel = "auth.profile.name.label".localized
        static let namePlaceholder = "auth.profile.name.placeholder".localized
        static let emailLabel = "auth.profile.email.label".localized
        static let emailPlaceholder = "auth.profile.email.placeholder".localized
        static let emailHelp = "auth.profile.email.help".localized
        static let cityLabel = "auth.profile.city.label".localized
        static let cityPlaceholder = "auth.profile.city.placeholder".localized
        static let addPhoto = "auth.profile.photo.add".localized
        static let privacy = "auth.profile.privacy".localized
        static let complete = "auth.profile.complete".localized
        static let settingUp = "auth.profile.setting_up".localized
    }

    // MARK: - Home
    enum Home {
        static func greetingMorning(_ name: String) -> String {
            String(format: "home.greeting.morning".localized, name)
        }
        static func greetingAfternoon(_ name: String) -> String {
            String(format: "home.greeting.afternoon".localized, name)
        }
        static func greetingEvening(_ name: String) -> String {
            String(format: "home.greeting.evening".localized, name)
        }
        static func greetingDefault(_ name: String) -> String {
            String(format: "home.greeting.default".localized, name)
        }
        static let subtitle = "home.subtitle".localized
        static let searchPlaceholder = "home.search.placeholder".localized
        static let popular = "home.popular".localized
        static let categories = "home.categories".localized
        static let loading = "home.loading".localized
        static func categoryServices(_ count: Int) -> String {
            String(format: "home.category.services".localized, count)
        }
        static let selectCity = "home.selectCity".localized
    }

    // MARK: - Service Detail
    enum Service {
        static let bookNow = "service.bookNow".localized
        static let price = "service.price".localized
        static let duration = "service.duration".localized
        static let about = "service.about".localized
        static let included = "service.included".localized
        static let excluded = "service.excluded".localized
        static let reviews = "service.reviews".localized
        static func reviewsCount(_ count: Int) -> String {
            String(format: "service.reviews.count".localized, count)
        }
        static let faqs = "service.faqs".localized
        static let related = "service.related".localized
        static let loading = "service.loading".localized
    }

    // MARK: - Search
    enum Search {
        static let title = "search.title".localized
        static let recent = "search.recent".localized
        static let popular = "search.popular".localized
        static let trending = "search.trending".localized
        static let results = "search.results".localized
        static let noResultsTitle = "search.noResults.title".localized
        static let noResultsMessage = "search.noResults.message".localized
        static let clear = "search.clear".localized
    }

    // MARK: - Booking
    enum Booking {
        static let title = "booking.title".localized
        static let stepAddress = "booking.step.address".localized
        static let stepDateTime = "booking.step.dateTime".localized
        static let stepSummary = "booking.step.summary".localized
        static let stepPayment = "booking.step.payment".localized

        // Address
        static let addressSelect = "booking.address.select".localized
        static let addressSaved = "booking.address.saved".localized
        static let addressAdd = "booking.address.add".localized
        static let addressDefault = "booking.address.default".localized
        static let addressHome = "booking.address.home".localized
        static let addressWork = "booking.address.work".localized
        static let addressOther = "booking.address.other".localized

        // Date & Time
        static let dateTimeSelect = "booking.dateTime.select".localized
        static let date = "booking.dateTime.date".localized
        static let time = "booking.dateTime.time".localized
        static let morning = "booking.dateTime.morning".localized
        static let afternoon = "booking.dateTime.afternoon".localized
        static let evening = "booking.dateTime.evening".localized
        static let available = "booking.dateTime.available".localized
        static let unavailable = "booking.dateTime.unavailable".localized

        // Summary
        static let summaryTitle = "booking.summary.title".localized
        static let service = "booking.summary.service".localized
        static let address = "booking.summary.address".localized
        static let dateTime = "booking.summary.dateTime".localized
        static let pricing = "booking.summary.pricing".localized
        static let basePrice = "booking.summary.basePrice".localized
        static let tax = "booking.summary.tax".localized
        static let discount = "booking.summary.discount".localized
        static let total = "booking.summary.total".localized
        static let promoCode = "booking.summary.promoCode".localized
        static let promoCodeApply = "booking.summary.promoCode.apply".localized
        static let promoCodeApplied = "booking.summary.promoCode.applied".localized

        // Payment
        static let paymentTitle = "booking.payment.title".localized
        static let paymentSelect = "booking.payment.select".localized
        static let paymentCash = "booking.payment.cash".localized
        static let paymentUpi = "booking.payment.upi".localized
        static let paymentCard = "booking.payment.card".localized
        static let paymentWallet = "booking.payment.wallet".localized
        static let paymentProcessing = "booking.payment.processing".localized
        static func payAmount(_ amount: Int) -> String {
            String(format: "booking.payment.pay".localized, amount)
        }

        // Confirmation
        static let confirmationTitle = "booking.confirmation.title".localized
        static let confirmationMessage = "booking.confirmation.message".localized
        static func bookingId(_ id: String) -> String {
            String(format: "booking.confirmation.bookingId".localized, id)
        }
        static let viewDetails = "booking.confirmation.viewDetails".localized
        static let goHome = "booking.confirmation.goHome".localized
    }

    // MARK: - Orders
    enum Orders {
        static let title = "orders.title".localized
        static let active = "orders.active".localized
        static let past = "orders.past".localized
        static let emptyActive = "orders.empty.active".localized
        static let emptyPast = "orders.empty.past".localized
        static let emptyMessage = "orders.empty.message".localized

        // Status
        static let statusPending = "orders.status.pending".localized
        static let statusConfirmed = "orders.status.confirmed".localized
        static let statusAssigned = "orders.status.assigned".localized
        static let statusInProgress = "orders.status.inProgress".localized
        static let statusCompleted = "orders.status.completed".localized
        static let statusCancelled = "orders.status.cancelled".localized

        // Detail
        static let detailBookingId = "orders.detail.bookingId".localized
        static let detailService = "orders.detail.service".localized
        static let detailProvider = "orders.detail.provider".localized
        static let detailAddress = "orders.detail.address".localized
        static let detailDateTime = "orders.detail.dateTime".localized
        static let detailAmount = "orders.detail.amount".localized
        static let detailStatus = "orders.detail.status".localized
        static let detailTimeline = "orders.detail.timeline".localized
        static let detailCancel = "orders.detail.cancel".localized
        static let detailReschedule = "orders.detail.reschedule".localized
        static let detailRate = "orders.detail.rateService".localized
        static let detailHelp = "orders.detail.help".localized

        // Actions
        static let cancelTitle = "orders.cancel.title".localized
        static let cancelMessage = "orders.cancel.message".localized
        static let cancelConfirm = "orders.cancel.confirm".localized
        static let cancelReason = "orders.cancel.reason".localized
        static let rescheduleTitle = "orders.reschedule.title".localized
    }

    // MARK: - Profile
    enum Profile {
        static let title = "profile.title".localized
        static let edit = "profile.edit".localized
        static let personalInfo = "profile.personalInfo".localized
        static let name = "profile.name".localized
        static let email = "profile.email".localized
        static let phone = "profile.phone".localized
        static let city = "profile.city".localized

        // Addresses
        static let addresses = "profile.addresses".localized
        static let addressesManage = "profile.addresses.manage".localized
        static let addressesAdd = "profile.addresses.add".localized
        static let addressesEdit = "profile.addresses.edit".localized
        static let addressesDelete = "profile.addresses.delete".localized
        static let addressesSetDefault = "profile.addresses.setDefault".localized
        static let addressesEmpty = "profile.addresses.empty".localized

        // Settings
        static let settings = "profile.settings".localized
        static let notifications = "profile.settings.notifications".localized
        static let language = "profile.settings.language".localized
        static let terms = "profile.settings.terms".localized
        static let privacy = "profile.settings.privacy".localized
        static let help = "profile.settings.help".localized
        static let about = "profile.settings.about".localized
        static func version(_ v: String) -> String {
            String(format: "profile.settings.version".localized, v)
        }

        // Notifications
        static let notificationsTitle = "profile.notifications.title".localized
        static let notificationsBooking = "profile.notifications.booking".localized
        static let notificationsOffers = "profile.notifications.offers".localized
        static let notificationsReminders = "profile.notifications.reminders".localized
    }

    // MARK: - Reviews
    enum Reviews {
        static let title = "reviews.title".localized
        static let write = "reviews.write".localized
        static let rating = "reviews.rating".localized
        static let comment = "reviews.comment".localized
        static let commentPlaceholder = "reviews.comment.placeholder".localized
        static let submit = "reviews.submit".localized
        static let thankyou = "reviews.thankyou".localized
    }

    // MARK: - Promo
    enum Promo {
        static let first20Title = "promo.first20.title".localized
        static let first20Subtitle = "promo.first20.subtitle".localized
        static let first20Cta = "promo.first20.cta".localized

        static let acCheckupTitle = "promo.acCheckup.title".localized
        static let acCheckupSubtitle = "promo.acCheckup.subtitle".localized
        static let acCheckupCta = "promo.acCheckup.cta".localized

        static let cleaningTitle = "promo.cleaning.title".localized
        static let cleaningSubtitle = "promo.cleaning.subtitle".localized
        static let cleaningCta = "promo.cleaning.cta".localized
    }

    // MARK: - Errors
    enum Error {
        static let network = "error.network".localized
        static let server = "error.server".localized
        static let unknown = "error.unknown".localized
        static let tryAgain = "error.tryAgain".localized
    }

    // MARK: - Validation
    enum Validation {
        static let required = "validation.required".localized
        static let emailInvalid = "validation.email.invalid".localized
        static let phoneInvalid = "validation.phone.invalid".localized
        static let nameMin = "validation.name.min".localized
        static let addressRequired = "validation.address.required".localized
    }

    // MARK: - Empty States
    enum Empty {
        static let defaultTitle = "empty.default.title".localized
        static let defaultMessage = "empty.default.message".localized
        static let searchTitle = "empty.search.title".localized
        static let searchMessage = "empty.search.message".localized
        static let bookingsTitle = "empty.bookings.title".localized
        static let bookingsMessage = "empty.bookings.message".localized
    }

    // MARK: - Alerts
    enum Alert {
        static let deleteTitle = "alert.delete.title".localized
        static let deleteMessage = "alert.delete.message".localized
        static let unsavedTitle = "alert.unsavedChanges.title".localized
        static let unsavedMessage = "alert.unsavedChanges.message".localized
        static let discard = "alert.discard".localized
    }

    // MARK: - Date & Time
    enum DateTime {
        static let today = "date.today".localized
        static let tomorrow = "date.tomorrow".localized
        static let yesterday = "date.yesterday".localized
        static let morning = "time.morning".localized
        static let afternoon = "time.afternoon".localized
        static let evening = "time.evening".localized
    }

    // MARK: - Loading
    enum Loading {
        static let services = "loading.services".localized
        static let details = "loading.details".localized
        static let booking = "loading.booking".localized
        static let payment = "loading.payment".localized
        static let profile = "loading.profile".localized
    }
}

// MARK: - String Extension

extension String {
    /// Returns localized string for the key
    var localized: String {
        NSLocalizedString(self, comment: "")
    }

    /// Returns localized string with format arguments
    func localized(with arguments: CVarArg...) -> String {
        String(format: self.localized, arguments: arguments)
    }
}
