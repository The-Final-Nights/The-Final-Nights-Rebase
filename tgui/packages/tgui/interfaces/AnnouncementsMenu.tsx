// THIS IS A TFN UI FILE
import { useState, useEffect } from 'react';

import { useBackend } from '../backend';
import { Window } from '../layouts';

type Post = {
  name: string;
  html_content: string;
  author_name: string;
  timestamp: string;
  can_edit: boolean;
};

type AnnouncementsMenuData = {
  camarilla_tabs: Post[];
  clan_tabs: Post[];
  clan_name: string | null;
  clan_id: string | null;
  can_post_camarilla: boolean;
  can_post_clan: boolean;
  is_admin: boolean;
};

type ActiveMenu = 'camarilla' | 'clan';
const getDateFromTimestamp = (ts: string): string =>
  ts.replace(/\s*\d{1,2}:\d{2}\s*(?:AM|PM)\s*$/i, '').trim() || ts;

const MAX_TITLE = 64;
const MAX_BODY = 1000;

export const AnnouncementsMenu = () => {
  const { act, data } = useBackend<AnnouncementsMenuData>();
  const {
    camarilla_tabs = [],
    clan_tabs = [],
    clan_name,
    clan_id,
    can_post_camarilla,
    can_post_clan,
    is_admin,
  } = data;

  const [activeMenu, setActiveMenu] = useState<ActiveMenu>('camarilla');
  const [composing, setComposing] = useState(false);
  const [draftTitle, setDraftTitle] = useState('');
  const [draftBody, setDraftBody] = useState('');
  const [draftAuthor, setDraftAuthor] = useState('');
  const [editingIndex, setEditingIndex] = useState<number | null>(null);
  const [draftEdit, setDraftEdit] = useState('');
  const [expandedDates, setExpandedDates] = useState<Set<string>>(new Set());

  const posts = activeMenu === 'camarilla' ? camarilla_tabs : clan_tabs;
  const canPost = !!(activeMenu === 'camarilla' ? can_post_camarilla : can_post_clan);
  const dateGroups: { date: string; items: { post: Post; index: number }[] }[] = [];
  const seenDates = new Map<string, number>();
  posts.forEach((post, i) => {
    const date = getDateFromTimestamp(post.timestamp);
    if (!seenDates.has(date)) {
      seenDates.set(date, dateGroups.length);
      dateGroups.push({ date, items: [] });
    }
    dateGroups[seenDates.get(date)!].items.push({ post, index: i });
  });
  useEffect(() => {
    const firstDate = dateGroups[0]?.date;
    setExpandedDates(firstDate ? new Set([firstDate]) : new Set());
    setEditingIndex(null);
  }, [activeMenu]);

  const toggleDate = (date: string) => {
    setExpandedDates((prev) => {
      const next = new Set(prev);
      if (next.has(date)) next.delete(date);
      else next.add(date);
      return next;
    });
  };

  const handleMenuSwitch = (menu: ActiveMenu) => {
    if (composing || editingIndex !== null) return;
    setActiveMenu(menu);
  };

  const handleSubmitPost = () => {
    if (!draftTitle.trim()) return;
    act('add_post', {
      which_menu: activeMenu,
      clan_id: clan_id,
      name: draftTitle.trim(),
      html_content: draftBody.trim(),
      author_name: draftAuthor.trim(),
    });
    setDraftTitle('');
    setDraftBody('');
    setDraftAuthor('');
    setComposing(false);
  };

  const handleSaveEdit = (index: number) => {
    act('set_content', {
      tab_index: index + 1,
      which_menu: activeMenu,
      clan_id: clan_id,
      html_content: draftEdit,
    });
    setEditingIndex(null);
  };

  return (
    <Window width={760} height={640} title="Announcements & News">
      <Window.Content
        fitted
        style={{
          display: 'flex',
          flexDirection: 'column',
          height: '100%',
          overflow: 'hidden',
          background: 'rgba(10, 10, 10, 0.9)',
        }}
      >
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '0',
            background: '#1a1a1a',
            borderBottom: '1px solid #3a3a3a',
            flexShrink: 0,
          }}
        >
          <MenuTab
            active={activeMenu === 'camarilla'}
            disabled={composing || editingIndex !== null}
            onClick={() => handleMenuSwitch('camarilla')}
          >
            Camarilla
          </MenuTab>
          <MenuTab
            active={activeMenu === 'clan'}
            disabled={composing || editingIndex !== null || !clan_id}
            onClick={() => handleMenuSwitch('clan')}
          >
            {clan_name ? `Clan ${clan_name}` : 'Clan'}
          </MenuTab>
          <div style={{ flex: 1 }} />
          {canPost && !composing && (
            <button
              onClick={() => setComposing(true)}
              style={{
                margin: '0 10px',
                padding: '4px 12px',
                background: 'transparent',
                border: '1px solid #888',
                color: '#ccc',
                cursor: 'pointer',
                fontSize: '12px',
                borderRadius: '3px',
              }}
            >
              + New Post
            </button>
          )}
        </div>
        {composing && (
          <div
            style={{
              padding: '12px 16px',
              background: '#1e1e1e',
              borderBottom: '1px solid #3a3a3a',
              flexShrink: 0,
            }}
          >
            <input
              type="text"
              placeholder="Post title..."
              value={draftTitle}
              maxLength={MAX_TITLE}
              onChange={(e) => setDraftTitle(e.target.value)}
              style={{
                width: '100%',
                padding: '6px 8px',
                background: '#111',
                border: '1px solid #444',
                color: '#ddd',
                fontSize: '13px',
                borderRadius: '3px',
                boxSizing: 'border-box',
                marginBottom: '8px',
                outline: 'none',
              }}
            />
            {!!is_admin && (
              <input
                type="text"
                placeholder="Author name (leave blank to use your character name)..."
                value={draftAuthor}
                maxLength={64}
                onChange={(e) => setDraftAuthor(e.target.value)}
                style={{
                  width: '100%',
                  padding: '6px 8px',
                  background: '#111',
                  border: '1px solid #444',
                  color: '#ddd',
                  fontSize: '13px',
                  borderRadius: '3px',
                  boxSizing: 'border-box',
                  marginBottom: '8px',
                  outline: 'none',
                }}
              />
            )}
            <textarea
              placeholder="Write your announcement..."
              value={draftBody}
              maxLength={MAX_BODY}
              onChange={(e) => setDraftBody(e.target.value)}
              style={{
                width: '100%',
                height: '90px',
                padding: '6px 8px',
                background: '#111',
                border: '1px solid #444',
                color: '#ddd',
                fontSize: '13px',
                borderRadius: '3px',
                boxSizing: 'border-box',
                resize: 'none',
                outline: 'none',
                fontFamily: 'inherit',
              }}
            />
            <div
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                marginTop: '6px',
              }}
            >
              <button
                onClick={handleSubmitPost}
                disabled={!draftTitle.trim()}
                style={{
                  padding: '4px 14px',
                  background: draftTitle.trim() ? '#2a2a2a' : '#1a1a1a',
                  border: '1px solid #888',
                  color: draftTitle.trim() ? '#ddd' : '#555',
                  cursor: draftTitle.trim() ? 'pointer' : 'default',
                  fontSize: '12px',
                  borderRadius: '3px',
                }}
              >
                Post
              </button>
              <button
                onClick={() => {
                  setComposing(false);
                  setDraftTitle('');
                  setDraftBody('');
                  setDraftAuthor('');
                }}
                style={{
                  padding: '4px 12px',
                  background: 'transparent',
                  border: '1px solid #555',
                  color: '#888',
                  cursor: 'pointer',
                  fontSize: '12px',
                  borderRadius: '3px',
                }}
              >
                Cancel
              </button>
              <span style={{ marginLeft: 'auto', color: '#555', fontSize: '11px' }}>
                {draftBody.length}/{MAX_BODY}
              </span>
            </div>
          </div>
        )}
        <div style={{ flex: 1, overflowY: 'auto', padding: '0' }}>
          {posts.length === 0 ? (
            <div
              style={{
                padding: '32px 20px',
                color: '#555',
                fontStyle: 'italic',
                textAlign: 'center',
                fontSize: '13px',
              }}
            >
              No announcements yet.
            </div>
          ) : (
            dateGroups.map(({ date, items }, groupIndex) => {
              const expanded = expandedDates.has(date);
              return (
                <div key={date}>
                  <div
                    onClick={() => toggleDate(date)}
                    style={{
                      display: 'flex',
                      alignItems: 'center',
                      gap: '8px',
                      padding: '7px 18px',
                      background: groupIndex === 0 ? '#1c1c1c' : '#161616',
                      borderBottom: '1px solid #2a2a2a',
                      borderTop: groupIndex > 0 ? '1px solid #2a2a2a' : undefined,
                      cursor: 'pointer',
                      userSelect: 'none',
                    }}
                  >
                    <span style={{ color: '#555', fontSize: '11px', lineHeight: 1 }}>
                      {expanded ? '▼' : '▶'}
                    </span>
                    <span
                      style={{
                        color: groupIndex === 0 ? '#888' : '#555',
                        fontSize: '11px',
                        letterSpacing: '0.06em',
                        textTransform: 'uppercase',
                      }}
                    >
                      {date}
                    </span>
                    <span style={{ color: '#444', fontSize: '11px', marginLeft: 'auto' }}>
                      {items.length} {items.length === 1 ? 'post' : 'posts'}
                    </span>
                  </div>
                  {expanded && items.map(({ post, index }) => (
                    <div
                      key={index}
                      style={{
                        padding: '14px 18px',
                        borderBottom: '1px solid #2a2a2a',
                      }}
                    >
                      <div
                        style={{
                          display: 'flex',
                          alignItems: 'baseline',
                          gap: '10px',
                          marginBottom: '8px',
                        }}
                      >
                        <div style={{ display: 'flex', flexDirection: 'column', gap: '2px' }}>
                          <span style={{ fontWeight: 'bold', color: '#ccc', fontSize: '14px' }}>
                            {post.name}
                          </span>
                          {!!post.author_name && (
                            <span style={{ color: '#777', fontSize: '11px' }}>
                              {post.author_name}
                            </span>
                          )}
                        </div>
                        <span
                          style={{
                            marginLeft: 'auto',
                            color: '#555',
                            fontSize: '11px',
                            whiteSpace: 'nowrap',
                            flexShrink: 0,
                          }}
                        >
                          {post.timestamp}
                        </span>
                      </div>
                      {editingIndex === index ? (
                        <>
                          <textarea
                            value={draftEdit}
                            onChange={(e) => setDraftEdit(e.target.value)}
                            style={{
                              width: '100%',
                              height: '90px',
                              padding: '6px 8px',
                              background: '#111',
                              border: '1px solid #444',
                              color: '#ddd',
                              fontSize: '13px',
                              borderRadius: '3px',
                              boxSizing: 'border-box',
                              resize: 'vertical',
                              outline: 'none',
                              fontFamily: 'inherit',
                            }}
                          />
                          <div style={{ display: 'flex', gap: '6px', marginTop: '6px' }}>
                            <button
                              onClick={() => handleSaveEdit(index)}
                              style={{
                                padding: '3px 12px',
                                background: '#2a2a2a',
                                border: '1px solid #888',
                                color: '#ddd',
                                cursor: 'pointer',
                                fontSize: '12px',
                                borderRadius: '3px',
                              }}
                            >
                              Save
                            </button>
                            <button
                              onClick={() => setEditingIndex(null)}
                              style={{
                                padding: '3px 10px',
                                background: 'transparent',
                                border: '1px solid #555',
                                color: '#888',
                                cursor: 'pointer',
                                fontSize: '12px',
                                borderRadius: '3px',
                              }}
                            >
                              Cancel
                            </button>
                          </div>
                        </>
                      ) : (
                        <>
                          <div
                            style={{
                              color: '#aaa',
                              fontSize: '13px',
                              lineHeight: '1.6',
                              whiteSpace: 'pre-wrap',
                              wordBreak: 'break-word',
                            }}
                          >
                            {post.html_content}
                          </div>
                          {!!post.can_edit && (
                            <button
                              onClick={() => {
                                setEditingIndex(index);
                                setDraftEdit(post.html_content);
                              }}
                              style={{
                                marginTop: '8px',
                                padding: '2px 10px',
                                background: 'transparent',
                                border: '1px solid #444',
                                color: '#666',
                                cursor: 'pointer',
                                fontSize: '11px',
                                borderRadius: '3px',
                              }}
                            >
                              Edit
                            </button>
                          )}
                        </>
                      )}
                    </div>
                  ))}
                </div>
              );
            })
          )}
        </div>
      </Window.Content>
    </Window>
  );
};

type MenuTabProps = {
  children: React.ReactNode;
  active: boolean;
  disabled?: boolean;
  onClick: () => void;
};

const MenuTab = ({ children, active, disabled, onClick }: MenuTabProps) => (
  <button
    onClick={disabled ? undefined : onClick}
    style={{
      padding: '10px 18px',
      background: 'transparent',
      border: 'none',
      borderBottom: active ? '2px solid #ccc' : '2px solid transparent',
      color: disabled ? '#444' : active ? '#ddd' : '#888',
      cursor: disabled ? 'default' : 'pointer',
      fontSize: '12px',
      fontWeight: active ? 'bold' : 'normal',
      letterSpacing: '0.05em',
      textTransform: 'uppercase',
      userSelect: 'none',
    }}
  >
    {children}
  </button>
);
