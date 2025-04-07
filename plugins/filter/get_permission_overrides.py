#!/usr/bin/env python

from typing import Dict


class FilterModule:
    def filters(self):
        return {"get_permission_overrides": self.get_permission_overrides}

    def get_permission_overrides(self, remote_path: str, overrides: Dict) -> Dict[str, str]:
        """
        Generate a dictionary of permission overrides for a given remote path.

        This method processes the provided overrides and associates them with the
        specified remote path, returning a dictionary of permissions.

        Args:
            remote_path (str): The path on the remote system for which the overrides
                are being applied.
            overrides (Dict): A dictionary containing permission overrides.

        Returns:
            Dict[str, str]: A dictionary mapping permission keys (owner, group, mode)
            to their respective override values for the specified remote path.
        """
        overrides_for_path: Dict | None = overrides.get(remote_path)
        return overrides_for_path if overrides_for_path else {}
