/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { EFFIGY_COLORS, EFFIGY_FONTS } from './constants-effigy';

export const THEMES = ['light', 'dark'] as const;

const BASE_COLORS = {
  DARK: {
    BG_BASE: '#202020',
    BG_SECOND: '#151515',
    BUTTON: '#404040',
    TEXT: '#A6A6A6',
    TEXT_IMPORTANT: '#A6A6A6',
    BG_IMPORTANT: '#492020',
  },
  LIGHT: {
    BG_BASE: '#EEEEEE',
    BG_SECOND: '#FFFFFF',
    BUTTON: '#FFFFFF',
    TEXT: '#000000',
    TEXT_IMPORTANT: '#A6A6A6',
    BG_IMPORTANT: '#910707',
  },
} as const;

export const COLORS = {
  DARK: { ...BASE_COLORS.DARK, ...EFFIGY_COLORS.DARK },
  LIGHT: { ...BASE_COLORS.LIGHT, ...EFFIGY_COLORS.LIGHT },
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
  {
    id: 'websocket',
    name: 'Websocket',
  },
] as const;

export const FONTS_DISABLED = 'Default';

export const FONTS = EFFIGY_FONTS;

export const WARN_AFTER_HIGHLIGHT_AMT = 10;
