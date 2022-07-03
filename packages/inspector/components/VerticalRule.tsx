export function VerticalRule(props: { className?: string }) {
  return <div className={`border-l border-l-black ${props.className}`} />;
}

VerticalRule.defaultProps = {
  className: "",
};
