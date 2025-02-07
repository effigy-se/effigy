/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { useSelector } from 'tgui/backend';
import { Color } from 'tgui-core/color';
import { Box } from 'tgui-core/components';
import { toFixed } from 'tgui-core/math';

import { selectPing } from './selectors';

export const PingIndicator = (props) => {
  const ping = useSelector(selectPing);
  const color = Color.lookup(ping.networkQuality, [
    new Color(240, 25, 125), // EffigyEdit Change - TGUI - Original: Color(220, 40, 40)
    new Color(255, 228, 94), // EffigyEdit Change - TGUI - Original: Color(220, 200, 40)
    new Color(44, 202, 255), // EffigyEdit Change - TGUI - Original: Color(60, 220, 40)
  ]).toString();
  const roundtrip = ping.roundtrip ? toFixed(ping.roundtrip) : '--';
  return (
    <div className="Ping">
      {/* EffigyEdit Change - TGUI - add width and ms*/}
      <Box className="Ping__indicator" backgroundColor={color} width="0.25em" />
      {roundtrip}ms
    </div>
  );
};
