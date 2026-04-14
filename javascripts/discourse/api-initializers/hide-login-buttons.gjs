import { apiInitializer } from "discourse/lib/api";

function hideLoginButtons() {
  const fixedSelectors = [
    ".login-with-passkey",
    ".passkey-login",
    ".btn-passkey",
    "button[data-auth-provider='passkey']",
    "button[data-provider='passkey']",
    "[data-auth-provider='passkey']",
    ".login-buttons .btn-social.oauth2_basic",
    ".login-buttons .btn-social[data-provider='oauth2_basic']",
    "button[data-provider='oauth2_basic']",
    "[data-auth-provider='oauth2_basic']"
  ];

  document.querySelectorAll(fixedSelectors.join(",")).forEach((el) => {
    el.style.setProperty("display", "none", "important");
  });

  const textMatchers = [
    "使用通行秘钥登录",
    "使用通行密钥登录",
    "passkey",
    "oa登录",
    "oa login"
  ];

  document.querySelectorAll("button, a, .btn, .btn-social").forEach((el) => {
    const t = (el.textContent || "").trim().toLowerCase();
    if (!t) return;

    if (textMatchers.some((k) => t.includes(k))) {
      el.style.setProperty("display", "none", "important");
    }
  });
}

export default apiInitializer("1.8.0", (api) => {
  api.onPageChange(() => {
    requestAnimationFrame(() => hideLoginButtons());
  });

  hideLoginButtons();

  const observer = new MutationObserver(() => hideLoginButtons());
  observer.observe(document.documentElement, { childList: true, subtree: true });
});
