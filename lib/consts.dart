
// Email validatsiyasi uchun regex
final RegExp EMAIL_VALIDATION_REGEX =
    RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");

// Parol validatsiyasi uchun regex
final RegExp PASSWORD_VALIDATION_REGEX = RegExp(
    r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$");

// Ism validatsiyasi uchun regex
final RegExp NAME_VALIDATION_REGEX =
    RegExp(r"\b[A-ZÀ-ÿ][-,a-z. ']+[ ]*");

// Placeholder profil rasmi URL'i
final String PLACEHOLDER_PFP =
    "https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17xVfY5qU34E3P7XzztTk4Kk5VL.jpg";
