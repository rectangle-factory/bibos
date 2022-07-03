import { trait } from "../types";
import { isOdd } from "../util";

export const TraitsTable = ({
  name,
  loading,
  tokenId,
  attributes,
}: {
  name: string;
  loading: boolean;
  tokenId: number;
  attributes: trait[];
}) => {
  const Loading = () => "loading";
  return (
    <div className="flex w-full flex-col">
      <span className="w-full px-8 py-2 text-white font-bold bg-white/5">{name}</span>

      {attributes.map(({ trait_type, value }, i) => (
        <span className={`w-full flex ${isOdd(i) ? "bg-white/5" : "bg-white/10"}`}>
          <span className="w-full px-8 py-1 text-white text-sm">{trait_type}</span>
          <span className="w-full px-8 py-1 text-primary text-sm font-medium">{value}</span>
        </span>
      ))}
    </div>
  );
};
