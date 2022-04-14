export enum IndexView {
  IMAGE,
  SVG,
}

export enum BibosStatus {
  UNFETCHED,
  FETCHING,
  FETCHED,
  ERROR,
}

export type trait = {
  trait_type: string;
  value: string;
};
