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

export type Trait = {
  trait_type: string;
  value: string;
};

export type NFTState = {
  metadata: {
    name: string;
    image: string;
    attributes: Trait[];
  };
  tokenId: number;
  svg: string;
};

export type Token = {
  name: string;
  tokenId: number;
  image: string;
  svg: string;
  attributes: Trait[];
};

export type GenericComponentProps = {
  children?: React.ReactNode;
  className: string;
  id?: string;
  key?: string;
};

export type ButtonProps = GenericComponentProps & {
  primary?: boolean;
  disabled?: boolean;
  onClick?: (e: React.MouseEvent<HTMLButtonElement>) => void;
};

export type IconSVGProps = {
  fill: string;
  stroke: string;
};
