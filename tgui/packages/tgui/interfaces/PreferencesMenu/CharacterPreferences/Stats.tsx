// THIS IS A DARKPACK UI FILE
import { Button, Stack, Tooltip } from 'tgui-core/components';
import { useBackend } from 'tgui/backend';

import { type PreferencesMenuData } from '../types';

export function StatsPage() {
  const { act, data } = useBackend<PreferencesMenuData>();
  if (!data) return;
  const stats = data.stats;
  const static_stats = data.static_stats;
  if (!stats || Object.keys(stats).length === 0) return null;

  // Group by category → subcategory using subtypes() order
  const grouped: Record<string, Record<string, string[]>> = {};

  Object.entries(static_stats).forEach(([path, statData]) => {
    const category = statData.category;
    const subcategory = statData.subcategory ?? 'General';
    if (!grouped[category]) grouped[category] = {};
    if (!grouped[category][subcategory]) grouped[category][subcategory] = [];
    grouped[category][subcategory].push(path);
  });

  return (
    <Stack vertical fill>
      {Object.entries(grouped).map(([category, subcats]) => (
        <Stack.Item key={category}>
          <b>{category}</b>
          <Stack>
            {Object.entries(subcats).map(([subcat, paths]) => (
              <Stack.Item key={subcat} style={{ marginLeft: '1em' }}>
                <Stack vertical>
                  <Stack.Item>
                    <i>{subcat}</i>
                  </Stack.Item>

                  {paths.map((statPath) => {
                    const statData = static_stats[statPath];
                    const score = stats[statPath];
                    const max = statData.max_score;
                    const label = statData.name;

                    const filled = '●'.repeat(score);
                    const empty = '○'.repeat(max - score);
                    const dots = filled + empty;

                    return (
                      <Stack.Item key={statPath}>
                        <Stack fill>
                          <Stack.Item grow basis="50%">
                            <Tooltip content={statData.desc}>{label}</Tooltip>
                          </Stack.Item>
                          <Stack.Item grow basis="50%" textAlign="right">
                            <Stack fill g={1}>
                              <Stack.Item>
                                <Button
                                  icon="minus"
                                  disabled={score <= 0}
                                  onClick={() =>
                                    act('decrease_stat', { stat: statPath })
                                  }
                                />
                              </Stack.Item>
                              <Stack.Item>
                                <Button
                                  icon="plus"
                                  disabled={score >= max}
                                  onClick={() =>
                                    act('increase_stat', { stat: statPath })
                                  }
                                />
                              </Stack.Item>
                              <Stack.Item>{dots}</Stack.Item>
                            </Stack>
                          </Stack.Item>
                        </Stack>
                      </Stack.Item>
                    );
                  })}
                </Stack>
              </Stack.Item>
            ))}
          </Stack>
        </Stack.Item>
      ))}
    </Stack>
  );
}
