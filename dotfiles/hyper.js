module.exports = {
  config: {
    fontSize: 12,
    fontFamily: '"Meslo LG M DZ for Powerline", "Menlo", monospace',
    cursorColor: 'rgba(240,242,53,0.7)',
    cursorShape: 'BLOCK',
    foregroundColor: '#fff',
    backgroundColor: '#111',
    borderColor: '#222',
    css: '',
    termCSS: '',
    padding: '0px',
    colors: {
      black: '#000000',
      red: '#ff0000',
      green: '#33ff00',
      yellow: '#ffff00',
      blue: '#0066ff',
      magenta: '#cc00ff',
      cyan: '#00ffff',
      white: '#d0d0d0',
      lightBlack: '#808080',
      lightRed: '#ff0000',
      lightGreen: '#33ff00',
      lightYellow: '#ffff00',
      lightBlue: '#0066ff',
      lightMagenta: '#cc00ff',
      lightCyan: '#00ffff',
      lightWhite: '#ffffff'
    },
    shell: '',
    shellArgs: ['--login'],
    env: {},
    bell: false,
    copyOnSelect: false
  },

  plugins: [
      'hypertile'
  ],

  // `~/.hyper_plugins/local/`
  localPlugins: [
  ]
};
