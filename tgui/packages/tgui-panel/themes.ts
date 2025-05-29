/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const THEMES = ['light', 'dark'];

const COLORS = {
  DARK: {
    BG_BASE: '#1a1c23', // EffigyEdit Change - TGUI - Original: #212020
    BG_SECOND: '#22252f', // EffigyEdit Change - TGUI - Original: #161515
    BUTTON: '#3a4050', // EffigyEdit Change - TGUI - Original: #414040
    TEXT: '#e7e9ee', // EffigyEdit Change - TGUI - Original: #161515
    TEXT_DARK: '#22252f', // EffigyEdit Add - TGUI
  },
  LIGHT: {
    BG_BASE: '#EEEEEE',
    BG_SECOND: '#FFFFFF',
    BUTTON: '#FFFFFF',
    TEXT: '#000000',
    TEXT_DARK: '#000000', // EffigyEdit Add - TGUI
  },
};

let setClientThemeTimer: NodeJS.Timeout;

/**
 * Darkmode preference, originally by Kmc2000.
 *
 * This lets you switch client themes by using winset.
 *
 * If you change ANYTHING in interface/skin.dmf you need to change it here.
 *
 * There's no way round it. We're essentially changing the skin by hand.
 * It's painful but it works, and is the way Lummox suggested.
 */
export const setClientTheme = (name) => {
  // Transmit once for fast updates and again in a little while in case we won
  // the race against statbrowser init.
  clearInterval(setClientThemeTimer);
  Byond.command(`.output statbrowser:set_theme ${name}`);
  setClientThemeTimer = setTimeout(() => {
    Byond.command(`.output statbrowser:set_theme ${name}`);
  }, 1500);

  const themeColor = COLORS[name.toUpperCase()];
  if (!themeColor) {
    return;
  }

  return Byond.winset({
    // Main windows
    'infobuttons.background-color': themeColor.BG_BASE,
    'infobuttons.text-color': themeColor.TEXT,
    'infowindow.background-color': themeColor.BG_BASE,
    'infowindow.text-color': themeColor.TEXT,
    'info_and_buttons.background-color': themeColor.BG_BASE,
    'info.background-color': themeColor.BG_BASE,
    'info.text-color': themeColor.TEXT,
    'browseroutput.background-color': themeColor.BG_BASE,
    'browseroutput.text-color': themeColor.TEXT,
    'outputwindow.background-color': themeColor.BG_BASE,
    'outputwindow.text-color': themeColor.TEXT,
    'mainwindow.background-color': themeColor.BG_BASE,
    'split.background-color': themeColor.BG_BASE,
    // Buttons
    'changelog.background-color': themeColor.BUTTON,
    'changelog.text-color': themeColor.TEXT,
    'rules.background-color': themeColor.BUTTON,
    'rules.text-color': themeColor.TEXT,
    'wiki.background-color': themeColor.BUTTON,
    'wiki.text-color': themeColor.TEXT,
    'forum.background-color': themeColor.BUTTON,
    'forum.text-color': themeColor.TEXT,
    'github.background-color': themeColor.BUTTON,
    'github.text-color': themeColor.TEXT,
    'report-issue.background-color': themeColor.BUTTON,
    'report-issue.text-color': themeColor.TEXT,
    'fullscreen-toggle.background-color': themeColor.BUTTON,
    'fullscreen-toggle.text-color': themeColor.TEXT,
    // EffigyEdit Add Start
    'adminhelp.background-color': themeColor.BUTTON,
    'adminhelp.text-color': themeColor.TEXT,
    'discord.background-color': themeColor.BUTTON,
    'discord.text-color': themeColor.TEXT,
    // EffigyEdit Add End
    // Status and verb tabs
    'output.background-color': themeColor.BG_BASE,
    'output.text-color': themeColor.TEXT,
    // Say, OOC, me Buttons etc.
    'saybutton.background-color': '#a4bad6', // EffigyEdit Change - TGUI - Original: BG_BASE
    'saybutton.text-color': themeColor.TEXT_DARK, // EffigyEdit Change - TGUI - Original: TEXT
    'oocbutton.background-color': '#cca300', // EffigyEdit Change - TGUI - Original: BG_BASE
    'oocbutton.text-color': themeColor.TEXT_DARK, // EffigyEdit Change - TGUI - Original: TEXT
    'mebutton.background-color': '#5975da', // EffigyEdit Change - TGUI - Original: BG_BASE
    'mebutton.text-color': themeColor.TEXT_DARK, // EffigyEdit Change - TGUI - Original: TEXT
    'asset_cache_browser.background-color': themeColor.BG_BASE,
    'asset_cache_browser.text-color': themeColor.TEXT,
    'tooltip.background-color': themeColor.BG_BASE,
    'tooltip.text-color': themeColor.TEXT,
    'input.background-color': themeColor.BG_SECOND,
    'input.text-color': themeColor.TEXT,
  });
};
