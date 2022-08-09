import { Trait } from "../types";
import { isOdd } from "../util";

export const TraitsTable = ({ name, attributes }: { name: string; attributes: Trait[] }) => {
  return (
    <div className="flex w-full flex-col">
      <span className="w-full px-8 py-2 text-label font-bold bg-[#21262d]">{name}</span>

      {attributes.map(({ trait_type, value }, i) => (
        <span
          key={trait_type}
          className={`w-full flex ${isOdd(i) ? "bg-[#21262d]" : "bg-[#161b22]"}`}
        >
          <span className="w-full px-8 py-1 text-label text-sm">{trait_type}</span>
          <span className="w-full px-8 py-1 text-primary text-sm">{value}</span>
        </span>
      ))}
    </div>
  );
};
