module.exports = {
  config: {
    fontSize: 13,
    fontFamily: '"Fira Code", "Meslo LG M DZ for Powerline", "Menlo", monospace',
    cursorShape: 'BLOCK',
    css: '',
    termCSS: `
        x-screen x-row {
            font-variant-ligatures: initial;
        }
    `,
    padding: '0px',
    shell: '',
    shellArgs: ['--login'],
    env: {},
    bell: false,
    copyOnSelect: false,
    enableVibrancy: true
  },

  plugins: [
      'hyperminimal',
      'hyper-one-light'
  ],
};
