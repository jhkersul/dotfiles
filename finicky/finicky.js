// Finicky: decides which app opens each link (set as the macOS default browser).
// Docs: https://github.com/johnste/finicky/wiki/Configuration-(v4)

// Linear workspaces whose links should open in the desktop app.
// Other linear.app pages (docs, changelog, OAuth/login) keep going to the browser.
const LINEAR_WORKSPACES = ["doji-labs"];

const isLinearWorkspaceLink = (url) =>
  url.host === "linear.app" &&
  LINEAR_WORKSPACES.includes(url.pathname.split("/")[1]);

export default {
  defaultBrowser: "company.thebrowser.dia",
  rewrite: [
    {
      // https://linear.app/doji-labs/issue/ABC-1 -> linear://doji-labs/issue/ABC-1
      match: isLinearWorkspaceLink,
      url: (url) => new URL(`linear:/${url.pathname}${url.search}${url.hash}`),
    },
  ],
  handlers: [
    {
      match: (url) => url.protocol === "linear:",
      browser: "com.linear",
    },
  ],
};
