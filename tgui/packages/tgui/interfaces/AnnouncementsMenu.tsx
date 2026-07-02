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

type AdminClan = {
  clan_id: string;
  clan_name: string;
  posts: Post[];
};

type AdminDept = {
  dept_id: string;
  dept_name: string;
  posts: Post[];
};

type AnnouncementsMenuData = {
  camarilla_tabs: Post[];
  clan_tabs: Post[];
  clan_name: string | null;
  clan_id: string | null;
  all_clan_tabs: AdminClan[];
  dept_tabs: Post[];
  dept_name: string | null;
  dept_id: string | null;
  all_dept_tabs: AdminDept[];
  can_post_camarilla: boolean;
  can_post_clan: boolean;
  can_post_dept: boolean;
  show_kindred_tabs: boolean;
  is_admin: boolean;
};

type ActiveMenu = 'camarilla' | 'clan' | 'department';
const MAX_TITLE = 64;
const MAX_BODY = 1000;
const formatID = (id: string): string => id.replace(/_/g, ' '); // because for some ungodly reason some of these have underscores in their strings

export const AnnouncementsMenu = () => {
  const { act, data } = useBackend<AnnouncementsMenuData>();
  const {
    camarilla_tabs = [],
    clan_tabs = [],
    clan_name,
    clan_id,
    all_clan_tabs = [],
    dept_tabs = [],
    dept_name,
    dept_id,
    all_dept_tabs = [],
    can_post_camarilla,
    can_post_clan,
    can_post_dept,
    show_kindred_tabs,
    is_admin,
  } = data;

  const [activeMenu, setActiveMenu] = useState<ActiveMenu>(
    show_kindred_tabs ? 'camarilla' : 'department',
  );
  const [composing, setComposing] = useState(false);
  const [draftTitle, setDraftTitle] = useState('');
  const [draftBody, setDraftBody] = useState('');
  const [draftAuthor, setDraftAuthor] = useState('');
  const [editingIndex, setEditingIndex] = useState<number | null>(null);
  const [draftEdit, setDraftEdit] = useState('');
  const [expandedDates, setExpandedDates] = useState<Set<string>>(new Set());
  const [adminClanId, setAdminClanId] = useState<string | null>(null);
  const [adminDeptId, setAdminDeptId] = useState<string | null>(null);

  const effectiveClanId =
    activeMenu === 'clan' && !!is_admin
      ? adminClanId || all_clan_tabs[0]?.clan_id || clan_id
      : clan_id;
  const effectiveDeptId =
    activeMenu === 'department' && !!is_admin
      ? adminDeptId || all_dept_tabs[0]?.dept_id || dept_id
      : dept_id;

  const activeClanPosts =
    activeMenu === 'clan' && !!is_admin && all_clan_tabs.length > 0
      ? (all_clan_tabs.find((c) => c.clan_id === effectiveClanId)?.posts ?? [])
      : clan_tabs;

  const activeDept =
    !!is_admin && all_dept_tabs.length > 0
      ? all_dept_tabs.find((d) => d.dept_id === effectiveDeptId)
      : null;

  const activeDeptPosts =
    activeMenu === 'department' && !!is_admin && all_dept_tabs.length > 0
      ? (activeDept?.posts ?? [])
      : dept_tabs;

  const activeDeptName = activeDept?.dept_name ?? dept_name;

  const posts =
    activeMenu === 'camarilla'
      ? camarilla_tabs
      : activeMenu === 'clan'
        ? activeClanPosts
        : activeDeptPosts;

  const canPost = !!(
    activeMenu === 'camarilla'
      ? can_post_camarilla
      : activeMenu === 'clan'
        ? can_post_clan
        : can_post_dept
  );

  const dateGroups: { date: string; items: { post: Post; index: number }[] }[] = [];
  const seenDates = new Map<string, number>();
  posts.forEach((post, i) => {
    const date = post.timestamp;
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
  }, [activeMenu, adminClanId, adminDeptId]);

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
      clan_id: effectiveClanId,
      dept_id: effectiveDeptId,
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
      clan_id: effectiveClanId,
      dept_id: effectiveDeptId,
      html_content: draftEdit,
    });
    setEditingIndex(null);
  };

  const showDeptTab = !!dept_id || !!is_admin;

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
          {!!show_kindred_tabs && (
            <>
              <MenuTab
                active={activeMenu === 'camarilla'}
                disabled={composing || editingIndex !== null}
                onClick={() => handleMenuSwitch('camarilla')}
              >
                Camarilla
              </MenuTab>
              <MenuTab
                active={activeMenu === 'clan'}
                disabled={composing || editingIndex !== null || (!clan_id && !is_admin)}
                onClick={() => handleMenuSwitch('clan')}
              >
                {clan_name ? `Clan ${formatID(clan_name)}` : 'Clan'}
              </MenuTab>
            </>
          )}
          {showDeptTab && (
            <MenuTab
              active={activeMenu === 'department'}
              disabled={composing || editingIndex !== null}
              onClick={() => handleMenuSwitch('department')}
            >
              {activeDeptName ? formatID(activeDeptName) : 'Department'}
            </MenuTab>
          )}
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
        {activeMenu === 'clan' && !!is_admin && all_clan_tabs.length > 0 && (
          <div
            style={{
              padding: '8px 16px',
              background: '#1a1a1a',
              borderBottom: '1px solid #3a3a3a',
              flexShrink: 0,
            }}
          >
            <select
              value={effectiveClanId || ''}
              onChange={(e) => {
                setAdminClanId(e.target.value);
                setComposing(false);
                setEditingIndex(null);
              }}
              style={{
                background: '#111',
                border: '1px solid #444',
                color: '#ddd',
                fontSize: '12px',
                padding: '4px 8px',
                borderRadius: '3px',
                outline: 'none',
              }}
            >
              {all_clan_tabs.map((c) => (
                <option key={c.clan_id} value={c.clan_id}>
                  {formatID(c.clan_name)}
                </option>
              ))}
            </select>
          </div>
        )}
        {activeMenu === 'department' && !!is_admin && all_dept_tabs.length > 0 && (
          <div
            style={{
              padding: '8px 16px',
              background: '#1a1a1a',
              borderBottom: '1px solid #3a3a3a',
              flexShrink: 0,
            }}
          >
            <select
              value={effectiveDeptId || ''}
              onChange={(e) => {
                setAdminDeptId(e.target.value);
                setComposing(false);
                setEditingIndex(null);
              }}
              style={{
                background: '#111',
                border: '1px solid #444',
                color: '#ddd',
                fontSize: '12px',
                padding: '4px 8px',
                borderRadius: '3px',
                outline: 'none',
              }}
            >
              {all_dept_tabs.map((d) => (
                <option key={d.dept_id} value={d.dept_id}>
                  {formatID(d.dept_name)}
                </option>
              ))}
            </select>
          </div>
        )}
        {composing && (
          <div
            style={{
              padding: '12px 16px',
              background: '#1e1e1e',
              borderBottom: '1px solid #3a3a3a',
              flexShrink: 0,
            }}
          >
            <div style={{ marginBottom: '8px', color: '#aaa', fontSize: '12px', lineHeight: '1.5' }}>
              <strong style={{ color: '#cc9900' }}>Note:</strong>
              <p style={{ margin: '4px 0' }}>
                Please do not make announcements that are not expressly IC. This includes things like announcing
                obviously non-canon events (i.e. stating someone died). Repeated instances of this may result in a job ban.
              </p>
              <p style={{ margin: '4px 0' }}>
                Remember that announcements are visible to a vast array of players, and that your character is in a
                position shared by others; there are multiple seneschals, there are multiple primogens, there are
                multiple managers, and so on. With this in mind, avoid using singular language, 'report to me', 'my city', 'my domain', 'my bar', etc. Instead, use language that reflects a plurality: 'your city', 'a primogen', 'an elder', 'a seneschal', etc.
              </p>
            </div>
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
