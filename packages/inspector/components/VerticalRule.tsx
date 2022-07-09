export function VerticalRule(props: { className?: string }) {
  return <div className={`border-l border-l-border ${props.className}`} />;
}

VerticalRule.defaultProps = {
  className: "",
};
