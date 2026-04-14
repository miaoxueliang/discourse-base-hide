import { apiInitializer } from "discourse/lib/api";

function hideLoginButtons() {
  const fixedSelectors = [
    "oauth2_basic",
    ".passkey-login-button"
  ];

  document.querySelectorAll(fixedSelectors.join(",")).forEach((el) => {
    el.style.setProperty("display", "none", "important");
  });

  const textMatchers = [
    "使用通行密钥登录",
    "OA登录"
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
