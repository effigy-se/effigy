/**
 * Effigy-specific UI overrides.
 */

export const EFFIGY_COLORS = {
  DARK: {
    BG_BASE: '#1A1C23',
    BG_SECOND: '#22252F',
    BUTTON: '#3A4050',
    TEXT: '#E7E9EE',
    TEXT_DARK: '#22252F',
    TEXT_IMPORTANT: '#F4F5F7',
    BG_IMPORTANT: '#860943',
  },
  LIGHT: {
    TEXT_IMPORTANT: '#F4F5F7',
    BG_IMPORTANT: '#F0197D',
    TEXT_DARK: '#000000',
  },
} as const;

export const EFFIGY_FONTS = [
  'Default',
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
