// THIS IS A DARKPACK UI FILE
import { Stack } from 'tgui-core/components';
import { useBackend } from 'tgui/backend';

import { type PreferencesMenuData } from '../types';

export function StatsPage() {
  const { act, data } = useBackend<PreferencesMenuData>();
  if (!data) return;
  const stats = data?.stats;
  if (!stats || !stats.length) return;
  return (
    <Stack vertical fill>
        extreame wip
      <Stack.Item>
        <Stack fill g={1} className="PreferencesMenu__Stats">
          {Object.entries(stats).map(([statPath, score]) => (
            <Stack.Item key={statPath}>
              <Stack vertical>
                <div>{statPath}</div>
                <div>{score}</div>
              </Stack>
            </Stack.Item>
          ))}
        </Stack>
      </Stack.Item>
    </Stack>
  );
}
