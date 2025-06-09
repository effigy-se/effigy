// Effigy replacement TGUI for AlertButton component

import { Button } from 'tgui-core/components';
import { capitalize } from 'tgui-core/string';

import { useBackend } from '../../backend';
import { SWIPE_NEEDED } from './constants';
import { CommsConsoleData } from './types';

type Props = {
  alertLevel: string;
  onClick: () => void;
};

export function GreenshiftButton(props: Props) {
  const { alertLevel, onClick } = props;

  const { act, data } = useBackend<CommsConsoleData>();
  const { canSetAlertLevel } = data;

  const thisIsCurrent = data.alertLevel === alertLevel;

  return (
    <Button
      icon="check-square"
      color={thisIsCurrent && 'green'}
      onClick={() => {
        if (thisIsCurrent) {
          return;
        }

        if (canSetAlertLevel === SWIPE_NEEDED) {
          onClick();
        } else {
          act('changeSecurityLevel', {
            newSecurityLevel: alertLevel,
          });
        }
      }}
    >
      {capitalize(alertLevel)}
    </Button>
  );
}

export function CircleButton(props: Props) {
  const { alertLevel, onClick } = props;

  const { act, data } = useBackend<CommsConsoleData>();
  const { canSetAlertLevel } = data;

  const thisIsCurrent = data.alertLevel === alertLevel;

  return (
    <Button
      icon="exclamation-circle"
      color={thisIsCurrent && 'blue'}
      onClick={() => {
        if (thisIsCurrent) {
          return;
        }

        if (canSetAlertLevel === SWIPE_NEEDED) {
          onClick();
        } else {
          act('changeSecurityLevel', {
            newSecurityLevel: alertLevel,
          });
        }
      }}
    >
      {capitalize(alertLevel)}
    </Button>
  );
}

export function MedicalButton(props: Props) {
  const { alertLevel, onClick } = props;

  const { act, data } = useBackend<CommsConsoleData>();
  const { canSetAlertLevel } = data;

  const thisIsCurrent = data.alertLevel === alertLevel;

  return (
    <Button
      icon="kit-medical"
      color={thisIsCurrent && 'violet'}
      onClick={() => {
        if (thisIsCurrent) {
          return;
        }

        if (canSetAlertLevel === SWIPE_NEEDED) {
          onClick();
        } else {
          act('changeSecurityLevel', {
            newSecurityLevel: alertLevel,
          });
        }
      }}
    >
      {capitalize(alertLevel)}
    </Button>
  );
}

export function EngiButton(props: Props) {
  const { alertLevel, onClick } = props;

  const { act, data } = useBackend<CommsConsoleData>();
  const { canSetAlertLevel } = data;

  const thisIsCurrent = data.alertLevel === alertLevel;

  return (
    <Button
      icon="wrench"
      color={thisIsCurrent && 'orange'}
      onClick={() => {
        if (thisIsCurrent) {
          return;
        }

        if (canSetAlertLevel === SWIPE_NEEDED) {
          onClick();
        } else {
          act('changeSecurityLevel', {
            newSecurityLevel: alertLevel,
          });
        }
      }}
    >
      {capitalize(alertLevel)}
    </Button>
  );
}

export function AlertButton(props: Props) {
  const { alertLevel, onClick } = props;

  const { act, data } = useBackend<CommsConsoleData>();
  const { canSetAlertLevel } = data;

  const thisIsCurrent = data.alertLevel === alertLevel;

  return (
    <Button
      icon="exclamation-triangle"
      color={thisIsCurrent && 'average'}
      onClick={() => {
        if (thisIsCurrent) {
          return;
        }

        if (canSetAlertLevel === SWIPE_NEEDED) {
          onClick();
        } else {
          act('changeSecurityLevel', {
            newSecurityLevel: alertLevel,
          });
        }
      }}
    >
      {capitalize(alertLevel)}
    </Button>
  );
}
// EffigyEdit Change End
