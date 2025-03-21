import { ByondUi } from 'tgui-core/components';

export const CharacterPreview = (props: { height: string; id: string }) => {
  return (
    <ByondUi
      width="225px"
      height={props.height}
      params={{
        id: props.id,
        type: 'map',
      }}
    />
  );
};
