import { Container } from "../components/Container";
import { useMultiRender } from "../hooks/useMultiRender";
import { useNFT } from "../hooks/useNFT";
import { decodeBase64 } from "../util";

export default function Index() {
  const { tokens, status, handleMultiRender } = useMultiRender(64);

  return (
    <Container>
      <div className="flex flex-wrap">
        {tokens !== null &&
          tokens.map((token, index) => {
            return (
              <div
                className={`h-32 w-32 overflow-hidden`}
                dangerouslySetInnerHTML={{ __html: token.svg }}
              />
            );
          })}
      </div>
    </Container>
  );
}
