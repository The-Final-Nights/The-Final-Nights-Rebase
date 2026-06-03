// THIS IS A TFN UI FILE
import { useState } from 'react';
import { useBackend } from 'tgui/backend';
import { Box, Button, DmIcon, Section, Stack } from 'tgui-core/components';
import { Window } from '../layouts';

const CLAN_ICONS = 'modular_darkpack/modules/vampire_the_masquerade/icons/vampire_clans.dmi';
const DECORATIVE: React.CSSProperties = {
  fontFamily: "'Cinzel Decorative', serif",
  fontWeight: 'bold',
};

type Member = {
  ckey: string;
  name: string;
  clan_icon: string | null;
  clan_name: string | null;
  join_date: string | null;
  last_seen: string | null;
  phone_number: string | null;
  is_online: boolean;
  portrait: string | null;
  is_viewer: boolean;
  is_leader: boolean;
};

type Data = {
  name: string;
  leader_name: string;
  is_admin: boolean;
  is_leader: boolean;
  members: Member[];
  viewer_name: string;
  can_retake: boolean;
};

const OnlineCircle = (props: { online: boolean }) => (
  <Box
    style={{
      width: '10px',
      height: '10px',
      borderRadius: '50%',
      backgroundColor: props.online ? '#4caf50' : '#9e9e9e',
      flexShrink: 0,
    }}
  />
);

export const Coterie = (props) => {
  const { act, data } = useBackend<Data>();
  const { name, leader_name, is_admin, is_leader, members = [], can_retake } = data;
  const windowTitle = is_admin ? `${name} (Admin View)` : name;
  const [selectedName, setSelectedName] = useState<string | null>(null);
  const selected = selectedName ? (members.find((m) => m.name === selectedName) ?? null) : null;

  if (selected) {
    return (
      <Window title={windowTitle} width={300} height={420}>
        <Window.Content style={{ background: 'linear-gradient(to bottom, #4a4a4a, #000000)' }}>
          <Stack vertical fill>
            <Stack.Item>
              <Button icon="arrow-left" onClick={() => setSelectedName(null)}>
                Back
              </Button>
            </Stack.Item>
            <Stack.Item grow style={{ position: 'relative', overflow: 'hidden' }}>
              <Box
                style={{
                  position: 'absolute',
                  inset: 0,
                  backgroundImage: selected.portrait
                    ? `url(data:image/jpeg;base64,${selected.portrait})`
                    : undefined,
                  backgroundSize: 'cover',
                  backgroundPosition: 'top center',
                  backgroundRepeat: 'no-repeat',
                  imageRendering: 'pixelated',
                }}
              />
              <Box
                style={{
                  position: 'absolute',
                  bottom: 0,
                  left: 0,
                  right: 0,
                  background: 'rgba(0,0,0,0.75)',
                  padding: '8px',
                  height: '50%',
                }}
              >
                <Stack vertical>
                  <Stack.Item>
                    <Stack align="center" justify="space-between">
                      <Stack.Item>
                        <Stack align="center">
                          <Stack.Item>
                            <Box style={DECORATIVE}>{selected.name}</Box>
                          </Stack.Item>
                          {selected.clan_icon && (
                            <Stack.Item>
                              <DmIcon
                                icon={CLAN_ICONS}
                                icon_state={selected.clan_icon}
                                height="32px"
                                width="32px"
                                style={{ imageRendering: 'pixelated' }}
                              />
                            </Stack.Item>
                          )}
                        </Stack>
                      </Stack.Item>
                      <Stack.Item>
                        <Stack align="center">
                          <Stack.Item>
                            <OnlineCircle online={selected.is_online} />
                          </Stack.Item>
                          <Stack.Item ml={1}>
                            {selected.is_online ? 'Online' : 'Offline'}
                          </Stack.Item>
                        </Stack>
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                  {selected.clan_name && (
                    <Stack.Item>
                      {selected.name}, the {selected.clan_name},{' '}
                      {selected.name === leader_name ? 'formed' : 'joined'}{' '}
                      {name} on {selected.join_date ?? 'Unknown'}.
                    </Stack.Item>
                  )}
                  {selected.phone_number && (
                    <Stack.Item>
                      Their phone number is {selected.phone_number}.
                    </Stack.Item>
                  )}
                  {!selected.is_online && selected.last_seen && (
                    <Stack.Item>Last seen {selected.last_seen}.</Stack.Item>
                  )}
                  {!!is_leader &&
                    !selected.is_viewer &&
                    !selected.is_leader && (
                      <Stack.Item mt={1}>
                        <Button
                          icon="user-minus"
                          color="bad"
                          onClick={() => act('kick', { ckey: selected.ckey })}
                        >
                          Kick
                        </Button>
                      </Stack.Item>
                    )}
                  {!!selected.is_viewer && (
                    <Stack.Item mt={1}>
                      <Button
                        icon="camera"
                        disabled={!can_retake}
                        tooltip={
                          !can_retake
                            ? 'You may only update your headshot once per minute.'
                            : undefined
                        }
                        onClick={() => act('retake_headshot')}
                      >
                        Retake Headshot
                      </Button>
                    </Stack.Item>
                  )}
                </Stack>
              </Box>
            </Stack.Item>
          </Stack>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window title={windowTitle} width={300} height={420}>
      <Window.Content
        style={{ background: 'linear-gradient(to bottom, #4a4a4a, #000000)' }}
      >
        <Stack vertical fill>
          <Stack.Item>
            <Section title="Leader">{leader_name}</Section>
          </Stack.Item>
          <Stack.Item grow>
            <Section title="Members" fill scrollable>
              {members.map((member) => (
                <Button
                  key={member.name}
                  fluid
                  mb={1}
                  onClick={() => setSelectedName(member.name)}
                  style={{ padding: '6px 8px', overflow: 'visible' }}
                >
                  <Stack align="center">
                    {member.clan_icon && (
                      <Stack.Item>
                        <DmIcon
                          icon={CLAN_ICONS}
                          icon_state={member.clan_icon}
                          height="32px"
                          width="32px"
                          style={{ imageRendering: 'pixelated' }}
                        />
                      </Stack.Item>
                    )}
                    <Stack.Item grow>{member.name}</Stack.Item>
                    <Stack.Item>
                      <OnlineCircle online={member.is_online} />
                    </Stack.Item>
                  </Stack>
                </Button>
              ))}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Stack justify="space-between" p={1}>
              {!!is_leader && (
                <>
                  <Stack.Item>
                    <Button icon="user-plus" onClick={() => act('invite')}>
                      Invite
                    </Button>
                  </Stack.Item>
                  <Stack.Item>
                    <Button icon="pen" onClick={() => act('rename')}>
                      Rename
                    </Button>
                  </Stack.Item>
                </>
              )}
              <Stack.Item>
                <Button
                  icon={is_leader ? 'skull' : 'right-from-bracket'}
                  color="bad"
                  onClick={() => act('leave')}
                >
                  {is_leader ? 'Disband' : 'Leave'}
                </Button>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
