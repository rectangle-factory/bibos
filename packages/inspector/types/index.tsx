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

export type trait = {
  trait_type: string;
  value: string;
};
