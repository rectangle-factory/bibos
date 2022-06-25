export type GenericComponentProps = {
  children?: React.ReactNode;
  className: string;
  id?: string;
  key?: string;
};

export type ButtonProps = GenericComponentProps & {
  onClick?: (e: React.MouseEvent<HTMLButtonElement>) => void;
};

export type IconSVGProps = {
  fill: string;
  stroke: string;
};

export enum IndexView {
  IMAGE,
  SVG,
}

export enum NFTStatus {
  UNFETCHED,
  FETCHING,
  FETCHED,
  ERROR,
}
