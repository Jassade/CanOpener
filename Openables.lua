local _, CanOpenerGlobal = ...
-- Populated by Openables/*.lua. Each file gates itself on the game flavor (CanOpenerGlobal.IsRetail /
-- CanOpenerGlobal.IsForever) so retail and Forever items are never registered on the other flavor.
-- Classic.lua is the one shared file: vanilla-era items exist on both.
CanOpenerGlobal.openables = {}
