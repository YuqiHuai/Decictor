import os

from omegaconf import OmegaConf

# tools/project_paths.py -> tools -> <project root>
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def get_project_root() -> str:
    """Root of this repository, resolved from the location of this file."""
    return PROJECT_ROOT


def register_resolvers():
    """Make ${project_root:} usable inside the hydra/omegaconf configs."""
    if not OmegaConf.has_resolver('project_root'):
        OmegaConf.register_new_resolver('project_root', get_project_root)


register_resolvers()
