/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

export const THEMES = ['light', 'dark'] as const;

export const COLORS = {
  DARK: {
    BG_BASE: '#1a1c23', // EffigyEdit Change - TGUI - Original: #202020
    BG_SECOND: '#22252f', // EffigyEdit Change - TGUI - Original: #151515
    BUTTON: '#3a4050', // EffigyEdit Change - TGUI - Original: #404040
    TEXT: '#e7e9ee', // EffigyEdit Change - TGUI - Original: #A6A6A6
    TEXT_DARK: '#22252f', // EffigyEdit Add - TGUI
  },
  LIGHT: {
    BG_BASE: '#EEEEEE',
    BG_SECOND: '#FFFFFF',
    BUTTON: '#FFFFFF',
    TEXT: '#000000',
    TEXT_DARK: '#000000', // EffigyEdit Add - TGUI
  },
} as const;

export const SETTINGS_TABS = [
  {
    id: 'general',
    name: 'General',
  },

  {
    id: 'textHighlight',
    name: 'Text Highlights',
  },
  {
    id: 'chatPage',
    name: 'Chat Tabs',
  },
  {
    id: 'statPanel',
    name: 'Stat Panel',
  },
] as const;

export const FONTS_DISABLED = 'Default';

/* EffigyEdit Change - TGUI - Original:
export const FONTS = [
  FONTS_DISABLED,
  'Verdana',
  'Arial',
  'Arial Black',
  'Comic Sans MS',
  'Impact',
  'Lucida Sans Unicode',
  'Tahoma',
  'Trebuchet MS',
  'Courier New',
  'Lucida Console',
] as const;
*/
export const FONTS = [
  FONTS_DISABLED,
  'IBM Plex Sans',
  'Titillium Web',
  'Arial',
  'Comic Sans MS',
  'Impact',
  'Tahoma',
  'Ubuntu Mono',
  'Courier New',
  'Lucida Console',
] as const;
// EffigyEdit Change End

export const WARN_AFTER_HIGHLIGHT_AMT = 10;
