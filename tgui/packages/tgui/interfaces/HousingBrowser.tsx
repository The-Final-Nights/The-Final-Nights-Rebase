import { Button, Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Guest = {
  name: string;
  ref: string;
};

type Instance = {
  owner_name: string;
  ref: string;
  can_enter: boolean;
  is_own: boolean;
};

type Data = {
  instances: Instance[];
  has_instance: boolean;
  slots_available: boolean;
  guests: Guest[];
};

export const HousingBrowser = () => {
  const { act, data } = useBackend<Data>();
  const { instances, has_instance, slots_available, guests } = data;

  return (
    <Window width={300} height={500} title="Housing Directory">
      <Window.Content scrollable>
        <Section>
          <Stack>
            <Stack.Item grow>
              <Button
                fluid
                icon="home"
                disabled={!has_instance && !slots_available}
                tooltip={
                  !has_instance && !slots_available
                    ? 'No housing slots are currently available.'
                    : undefined
                }
                onClick={() => act('go_home')}
              >
                {has_instance ? 'Go to My House' : 'Claim a House'}
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button icon="door-open" onClick={() => act('exit')}>
                Exit
              </Button>
            </Stack.Item>
          </Stack>
        </Section>
        {has_instance && (
          <Section title="Guests">
            {guests.length === 0 ? (
              <Stack.Item color="label">No guests allowed in.</Stack.Item>
            ) : (
              guests.map((g) => (
                <Stack key={g.ref} justify="space-between" align="center">
                  <Stack.Item grow>{g.name}</Stack.Item>
                  <Stack.Item>
                    <Button
                      icon="user-minus"
                      color="bad"
                      onClick={() => act('remove_guest', { ref: g.ref })}
                    >
                      Remove
                    </Button>
                  </Stack.Item>
                </Stack>
              ))
            )}
          </Section>
        )}
        <Section title="Directory">
          {instances.length === 0 ? (
            <Stack.Item color="label">No residences loaded yet.</Stack.Item>
          ) : (
            instances.map((inst) => (
              <Stack key={inst.ref} justify="space-between" align="center">
                <Stack.Item grow>{inst.owner_name}&apos;s House</Stack.Item>
                <Stack.Item>
                  {inst.is_own ? null : inst.can_enter ? (
                    <Button
                      icon="door-open"
                      onClick={() => act('teleport', { ref: inst.ref })}
                    >
                      Enter
                    </Button>
                  ) : (
                    <Button
                      icon="hand-fist"
                      onClick={() => act('knock', { ref: inst.ref })}
                    >
                      Knock
                    </Button>
                  )}
                </Stack.Item>
              </Stack>
            ))
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};
